extends VehicleBody3D
class_name MirenaCar

enum PilotMode { NO_PILOT, MANUAL, ROS, TRACK_RAIL }

# --- Configuration ---
const POWER_LIM = 80000 # W
const MOTOR_PEAK_TRQ = 100 # Nm
const GEAR_RATIO = 5 # 1:5
const WHEEL_RADIUS = 0.23 # m
const BRAKE_F = 20
const MAX_STEER = deg_to_rad(30)
## Forward speed over which regen is at full strength. Below it regen fades out
## and the friction brakes take over, so a braking command can only ever remove
## speed: /control carries a [-1, 1] throttle where -1 is full braking, never
## reverse, and the car must not drive backwards on one.
const REGEN_FADE_SPEED = 0.5 # m/s

# --- Pilot Settings ---
@export var pilot: PilotMode = PilotMode.NO_PILOT
@export var rail_speed: float = 10.0
@export var rail_look_ahead: float = 3.0
var _rail_progress: float = 0.0
var path : Path3D

# --- ROS Variables ---
@export var frame_id: String = "car/cog"
## Rate the rear wheel speeds go out at, in Hz.
##
## Deliberately not the physics rate: physics runs at 400 Hz here, while on the
## car these numbers arrive as the WheelInfo CAN frame and a consumer sees them
## at whatever rate the ECU broadcasts. Publishing every physics tick would give
## the sim a sensor four times livelier than the real one.
@export var wheel_speed_rate: float = 100.0
var _node: RosNode
# Publishers
var _state_pub: RosPublisher
var _as_info_pub : RosPublisher
var _perception_pub: RosPublisher
var _slam_pub: RosPublisher
var _inferred_control_pub: RosPublisher
var _wheel_speeds_pub: RosPublisher
var _tf_broadcaster: RosTfBroadcaster
var _debug_tim : RosTimer
var _wheel_speeds_tim : RosTimer
# Subscribers
var _control_sub: RosSubscriber
var _mission_info_sub: RosSubscriber
var _ros_gas: float = 0.0
var _ros_steer: float = 0.0

# --- Internal State ---
var origin  : Transform3D = Transform3D.IDENTITY
var gas: float = 0.0
var _steer_smoothed: float = 0.0
var slam_cones: Array = [] # Seen cones
var _as_info : RosMirenaCommonAsInfo
var _mission_info

@onready var car_state : RosMirenaCommonCar = RosMirenaCommonCar.new()
@onready var wheel_speeds : RosMirenaCommonWheelSpeeds = RosMirenaCommonWheelSpeeds.new()

func _ready():
	## ROS — no namespace: all topic names below are absolute
	_node = RosNode.new()
	_node.init("mirena_car", "")
	## Publishers (absolute topic names from topic contract)
	_as_info_pub          = _node.create_publisher("/as_status",        "mirena_common/msg/AsInfo")
	_state_pub            = _node.create_publisher("/debug/state/car", "mirena_common/msg/Car")
	_perception_pub       = _node.create_publisher("/debug/perception",  "mirena_common/msg/EntityList")
	_slam_pub             = _node.create_publisher("/debug/slam",        "mirena_common/msg/EntityList")
	_inferred_control_pub = _node.create_publisher("/inferred_control",  "mirena_common/msg/CarControl")
	## Rear wheel speeds. Not a debug topic -- this is the same /sensors/*
	## interface mirena_can serves on the car, so nothing downstream can tell
	## which one it is talking to. Best-effort/volatile to match the
	## SensorDataQoS the hardware node publishes with.
	var wheel_qos := RosQoS.new()
	wheel_qos.history = RosQoS.KEEP_LAST
	wheel_qos.depth = 5
	wheel_qos.reliability = RosQoS.BEST_EFFORT
	wheel_qos.durability = RosQoS.VOLATILE
	_wheel_speeds_pub = _node.create_publisher(
		"/sensors/wheel_speeds", "mirena_common/msg/WheelSpeeds", wheel_qos)

	_tf_broadcaster = _node.create_tf_broadcaster()
	_publish_debug_map_tf()

	# State setup
	_as_info = RosMirenaCommonAsInfo.new()
	_as_info.status = 0
	_mission_info = RosMirenaCommonMissionInfo.new()
	_mission_info.status = 0
	## Publisher timers
	_debug_tim = _node.create_timer(0.1, _debug_publish)
	_wheel_speeds_tim = _node.create_timer(1.0 / wheel_speed_rate, _publish_wheel_speeds)
	# Subscribers
	_control_sub = _node.create_subscription("/control", "mirena_common/msg/CarControl", _on_control)
	_mission_info_sub = _node.create_subscription("/system/mission_status","mirena_common/msg/MissionInfo",_on_mission_info)

	# Camera Registration
	Sim.register_camera($TPCam)
	Sim.register_camera($FPCam)

func _on_control(msg):
	_ros_gas = msg.gas
	_ros_steer = msg.steer_angle
	
func _on_mission_info(msg):
	_mission_info = msg
	
func _physics_process(delta: float) -> void:
	# Process driving commands
	match pilot:
		PilotMode.NO_PILOT:
			_process_no_pilot()
			_apply_vehicle_physics(delta)
		PilotMode.MANUAL:
			_process_manual_pilot(delta)
			_apply_vehicle_physics(delta)
		PilotMode.ROS:
			_process_ros_pilot()
			_apply_vehicle_physics(delta)
		PilotMode.TRACK_RAIL:
			_process_track_rail(delta)
	
	if global_position.y < -1:
		reset_position()

	_publish_car_state()
		
# Publish Debug Info
func _debug_publish():
	_publish_perception()
	_publish_slam()
	_publish_control()
	_as_info_pub.publish(_as_info)
# ROS Publishing

## Ground-truth car state (debug). The fused /state/car and the odom->car/cog
## TF are owned by mirena_state; this topic feeds its ground_truth_passthrough
## mode and serves as a reference to compare the EKF against.
func _publish_car_state():
	var now = _node.now()
	car_state.header.stamp = now
	car_state.header.frame_id = "debug_odom"
	car_state.child_frame_id = frame_id  # "car/cog"
	
	var odom_transform : Transform3D = origin.inverse() * global_transform
	# 1. Pose and Dynamics
	car_state.x = -odom_transform.origin.z
	car_state.y = -odom_transform.origin.x
	car_state.psi = odom_transform.basis.get_euler().y
	
	var local_vel = _body_velocity()
	car_state.u = -local_vel.z
	car_state.v = -local_vel.x
	car_state.omega = angular_velocity.y
	
	# 2. Covariance Setup (6x6 matrix flattened)
	# Indices for diagonal: x=0, y=7, psi=14, u=21, v=28, omega=35
	var cov = []
	cov.resize(36)
	for i in range(36):
		cov[i] = 0.0 # Initialize all to zero
		
	# Set Variances (Standard Deviation squared)
	# These values represent "how much we trust the simulator"
	cov[0]  = 0 # x variance (m^2)
	cov[7]  = 0  # y variance (m^2)
	cov[14] = 0 # psi variance (rad^2)
	cov[21] = 0  # u variance (m/s^2)
	cov[28] = 0  # v variance (m/s^2)
	cov[35] = 0  # omega variance (rad/s^2)
	
	car_state.covariance = cov
	_state_pub.publish(car_state)

	# The ground-truth frames hang off the car: the inverse of the pose above
	var odom_to_car := Transform3D(Basis(Vector3.UP, car_state.psi), Vector3(-car_state.y, 0.0, -car_state.x))
	_tf_broadcaster.send_transform(odom_to_car.affine_inverse(), "debug_odom", frame_id, false, now)

## Ground truth is published as a subtree of the car, car/cog -> debug_odom -> debug_map,
## not as a second root. car/cog keeps its one parent (odom, owned by mirena_state), the
## pipeline never sees the debug frames, and RViz shows ground truth against the estimate:
## with fixed frame map, the true world around the estimated car; with fixed frame debug_map,
## the estimate drifting over the true world. Both transforms are planar (x, y, yaw), like
## car_state and the pipeline's odom -> car/cog, so body roll and pitch don't tilt the world.
##
## debug_odom is the start pose (origin) and debug_map the Godot world, so debug_map hangs
## off debug_odom by the inverse of origin. Static, re-sent whenever origin changes.
func _publish_debug_map_tf() -> void:
	if not _tf_broadcaster:
		return
	var map_to_odom := Transform3D(Basis(Vector3.UP, origin.basis.get_euler().y), Vector3(origin.origin.x, 0.0, origin.origin.z))
	_tf_broadcaster.send_transform(map_to_odom.affine_inverse(), "debug_map", "debug_odom", true)



## Rear wheel speeds
func _publish_wheel_speeds():
	wheel_speeds.header.stamp = _node.now()
	wheel_speeds.header.frame_id = frame_id  # "car/cog"
	wheel_speeds.rl = -$RL_WHEEL.get_rpm()
	wheel_speeds.rr = -$RR_WHEEL.get_rpm()
	_wheel_speeds_pub.publish(wheel_speeds)


func _publish_perception():
	var cones = get_cones_in_sight(12.0)
	for cone in cones:
		if not slam_cones.has(cone): slam_cones.append(cone)
	
	var msg = RosMirenaCommonEntityList.new()
	msg.header.stamp = _node.now()
	msg.header.frame_id = frame_id  # "car/cog"
	msg.entities = cones.map(func(c): return _to_ent(c))
	_perception_pub.publish(msg)

func _publish_slam():
	var msg = RosMirenaCommonEntityList.new()
	msg.header.stamp = _node.now()
	msg.header.frame_id = "debug_map" # Ground truth: global positions, not the pipeline's map
	slam_cones = slam_cones.filter(func(c): return is_instance_valid(c))
	# Use Identity transform for global positions
	msg.entities = slam_cones.map(func(c): return _to_ent(c,true))
	_slam_pub.publish(msg)

func _publish_control():
	var msg = RosMirenaCommonCarControl.new()
	msg.header.stamp = _node.now()
	msg.header.frame_id = frame_id  # "car/cog"
	msg.gas = self.gas
	msg.steer_angle = self.steering

	_inferred_control_pub.publish(msg)

# Conversion helper
func _to_ent(cone: Node3D, global : bool = false  ) -> RosMirenaCommonEntity:
	var ent = RosMirenaCommonEntity.new()
	var pos =  cone.global_position if global else to_local(cone.global_position)
	ent.type = cone.get_type_as_string()
	
	# ROS Swizzle: Forward=Z, Left=-X, Up=Y
	ent.position.x = -pos.z
	ent.position.y = -pos.x
	ent.position.z = pos.y
	return ent


# --- Pilot Logic ---

func _process_no_pilot() -> void:
	# Zero out all inputs to ensure the car stays stationary or coasts to a stop
	self.gas = 0.0
	self.steering = 0.0
	self.brake = BRAKE_F # Keep brakes engaged in No Pilot mode

func _process_manual_pilot(delta: float) -> void:
	var steer_input = Input.get_action_strength("manual_steer_l") - Input.get_action_strength("manual_steer_r")
	_steer_smoothed = _smooth_steer(_steer_smoothed, steer_input, delta, 2.0)
	
	self.gas = Input.get_action_strength("manual_gas_pos") - Input.get_action_strength("manual_gas_neg")
	self.steering = _steer_smoothed * MAX_STEER
	self.brake = Input.get_action_strength("EBS") * BRAKE_F

func _process_ros_pilot() -> void:
	self.gas = _ros_gas
	self.steering = _ros_steer 
	self.brake = 0.0 # Brakes handled by ROS if needed

func _process_track_rail(delta: float) -> void:
	if not path or not path.curve: 
		return

	# 1. Advance progress (meters)
	_rail_progress += rail_speed * delta
	
	# 2. Sample the curve math directly (No PathFollow node needed!)
	# This gives us the local Transform3D (position + orientation)
	var local_transform = path.curve.sample_baked_with_rotation(_rail_progress, true)
	
	# 3. Convert to Global Space
	# We multiply by the path's transform so the car follows the path where it sits in the world
	var target_global_transform = path.global_transform * local_transform
	
	# 4. Movement (Your move_and_collide approach)
	var motion = target_global_transform.origin - global_position
	var collision = move_and_collide(motion)
	if collision:
		var remainder = collision.get_remainder().slide(collision.get_normal())
		move_and_collide(remainder)

	# 5. Look-Ahead Orientation
	var look_ahead_p = _rail_progress + rail_look_ahead
	var look_target_local = path.curve.sample_baked_with_rotation(look_ahead_p, true)
	var look_target_global = path.global_transform * look_target_local
	
	
	# Smoothly rotate the car to face the look-ahead point
	global_transform.basis = global_transform.basis.slerp(
		look_target_global.basis .orthonormalized(), 
		5.0 * delta
	).orthonormalized()
# --- Physics & Low Level Control ---

## Velocity in the car's own frame. Godot's forward is -Z, so the forward speed
## is -z and the leftward speed is -x -- the same quantities ROS calls u and v.
## Both the drivetrain and the published state read the car's motion through
## here so they cannot end up disagreeing about which way the car is pointing.
func _body_velocity() -> Vector3:
	return global_basis.inverse() * linear_velocity


func _apply_vehicle_physics(_delta: float) -> void:
	# Forward speed in the car's own frame. Reading linear_velocity.z straight
	# off gives the *world's* z, which only means "forward speed" while the car
	# happens to point down that axis, and carries the opposite sign besides --
	# Godot's forward is -Z. Both mistakes together are what turned a braking
	# command into reverse throttle: driving forward it read negative and killed
	# the regen entirely, at a standstill it read zero and pushed the car
	# backwards, and once rolling backwards it read positive and pushed harder.
	var u = -_body_velocity().z
	var max_fx_motor = MOTOR_PEAK_TRQ * GEAR_RATIO / WHEEL_RADIUS

	# Regen can only take away speed that is there, so it scales with the speed
	# there is to take: full strength above REGEN_FADE_SPEED, nothing at rest or
	# already rolling backwards. This is what bounds braking at zero.
	var throttle = max(gas, 0.0)
	var braking = max(-gas, 0.0)
	var regen_scale = clamp(u / REGEN_FADE_SPEED, 0.0, 1.0)
	var fx = (throttle - braking * regen_scale) * max_fx_motor

	$RL_WHEEL.engine_force = fx / 2.0
	$RR_WHEEL.engine_force = fx / 2.0

	# Apply braking force to wheels. The friction brakes pick up exactly what
	# regen gives up as the car slows, so a stopped car under a braking command
	# is held there instead of left to creep or roll away down a slope.
	var brake_force = min(brake + braking * (1.0 - regen_scale) * BRAKE_F, BRAKE_F)
	$RL_WHEEL.brake = brake_force
	$RR_WHEEL.brake = brake_force

func _smooth_steer(current: float, target: float, delta: float, speed: float) -> float:
	var diff = target - current
	var t = clamp(abs(diff), 0.0, 1.0)
	var _ease = t * t * (3.0 - 2.0 * t) 
	current += sign(diff) * _ease * speed * delta
	if sign(target - current) != sign(diff): current = target
	return clamp(current, -1.0, 1.0)

# --- Interface & Utility ---

func set_origin(transform, reset_vel: bool = false) -> void:
	origin = transform
	_publish_debug_map_tf()
	if reset_vel:
		linear_velocity = Vector3.ZERO
		angular_velocity = Vector3.ZERO
	await get_tree().process_frame
	set_deferred("global_transform", origin)

func reset_position() -> void:
	set_origin(Sim.track.origin, true)
	self.gas = 0;
	self.steering = 0;
	self.brake = 0;
	_rail_progress = 0
	# Reset slam
	slam_cones.clear()

func cone_collision_set(enable: bool) -> void:
	self.collision_layer = (self.collision_layer & ~2) | (2 * int(enable))
	self.collision_mask = (self.collision_mask & ~2) | (2 * int(enable))
	
func get_cones_in_sight(max_dist: float = 10.0) -> Array:
	var visible_cones: Array = []
	var camera = $Camera._camera
	if not camera: return []
	for cone in get_tree().get_nodes_in_group("Cones"):
		if global_position.distance_to(cone.global_position) < max_dist:
			if camera.is_position_in_frustum(cone.global_position):
				visible_cones.append(cone)
	return visible_cones
