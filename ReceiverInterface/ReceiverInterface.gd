@abstract
class_name ReceiverInterface extends Node

func wait_for_data() -> PackedByteArray:
	var data = await get_data()
	DebugLogger.trace("Data received: " + str(data))
	return data

@abstract func get_data() -> PackedByteArray
