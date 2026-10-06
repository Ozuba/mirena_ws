extends RosMsg
class_name RosStereoMsgsDisparityImage

const ROS_TYPE_NAME = "stereo_msgs/msg/DisparityImage"

func _init():
	init(ROS_TYPE_NAME)

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var image : RosSensorMsgsImage:
	get: return get_member(&"image") as RosMsg
	set(v): set_member(&"image", v)

var f : float:
	get: return get_member(&"f")
	set(v): set_member(&"f", v)

var t : float:
	get: return get_member(&"t")
	set(v): set_member(&"t", v)

var valid_window : RosSensorMsgsRegionOfInterest:
	get: return get_member(&"valid_window") as RosMsg
	set(v): set_member(&"valid_window", v)

var min_disparity : float:
	get: return get_member(&"min_disparity")
	set(v): set_member(&"min_disparity", v)

var max_disparity : float:
	get: return get_member(&"max_disparity")
	set(v): set_member(&"max_disparity", v)

var delta_d : float:
	get: return get_member(&"delta_d")
	set(v): set_member(&"delta_d", v)

