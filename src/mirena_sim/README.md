# mirena_sim

A Formula Student Driverless simulator built on Godot 4 and ROS 2 (Jazzy), using
[rclgd](https://github.com/Ozuba/rclgd). It simulates the car on a cone track and publishes lidar,
camera, IMU, GNSS and wheel speeds, plus ground truth for evaluating your stack.

## Build and run

```bash
colcon build --packages-select mirena_sim
source install/setup.bash
ros2 run mirena_sim mirena_sim --ros-args -p track:=random
```

`track` is either `random`, which generates a Trackdrive layout, or the path to a track `.json`
file (examples are in `TrackFiles/`).

## Edit

```bash
ros2 run rclgd godot --editor --path src/mirena_sim
```

## Main interfaces

| Topic | Type |
|-------|------|
| `/control` (sub) | `mirena_common/CarControl` |
| `/lidar/lidar` | `sensor_msgs/PointCloud2` |
| `/camera/image_raw`, `/camera/camera_info` | `sensor_msgs/Image`, `CameraInfo` |
| `/ros_imu/data` | `sensor_msgs/Imu` |
| `/ros_gps/fix` | `sensor_msgs/NavSatFix` |
| `/sensors/wheel_speeds` | `mirena_common/WheelSpeeds` |

Sensor topics use best-effort QoS. Ground truth is published under `/debug/*` and
`/track_manager/*`.

Full documentation, covering setup, architecture, vehicle configuration and sensor models, is in
[`docs/`](../../docs) at the workspace root.

## License

MIT, see [LICENSE](LICENSE).
