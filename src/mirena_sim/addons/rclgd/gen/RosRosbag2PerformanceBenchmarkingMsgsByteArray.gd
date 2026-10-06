extends RosMsg
class_name RosRosbag2PerformanceBenchmarkingMsgsByteArray

func _init():
	init("rosbag2_performance_benchmarking_msgs/msg/ByteArray")

var data : PackedByteArray:
	get: return get_member(&"data")
	set(v): set_member(&"data", v)

