extends RosMsg
class_name RosPendulumMsgsRttestResults

const ROS_TYPE_NAME = "pendulum_msgs/msg/RttestResults"

func _init():
	init(ROS_TYPE_NAME)

var stamp : RosBuiltinInterfacesTime:
	get: return get_member(&"stamp") as RosMsg
	set(v): set_member(&"stamp", v)

var command : RosPendulumMsgsJointCommand:
	get: return get_member(&"command") as RosMsg
	set(v): set_member(&"command", v)

var state : RosPendulumMsgsJointState:
	get: return get_member(&"state") as RosMsg
	set(v): set_member(&"state", v)

var cur_latency : int:
	get: return get_member(&"cur_latency")
	set(v): set_member(&"cur_latency", v)

var mean_latency : float:
	get: return get_member(&"mean_latency")
	set(v): set_member(&"mean_latency", v)

var min_latency : int:
	get: return get_member(&"min_latency")
	set(v): set_member(&"min_latency", v)

var max_latency : int:
	get: return get_member(&"max_latency")
	set(v): set_member(&"max_latency", v)

var minor_pagefaults : int:
	get: return get_member(&"minor_pagefaults")
	set(v): set_member(&"minor_pagefaults", v)

var major_pagefaults : int:
	get: return get_member(&"major_pagefaults")
	set(v): set_member(&"major_pagefaults", v)

