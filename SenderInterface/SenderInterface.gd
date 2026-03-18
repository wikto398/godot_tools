@abstract
class_name SenderInterface extends Node

func send_data(data: PackedByteArray) -> void:
    DebugLogger.trace("Data for sending: " + str(data))
    _send_data(data)

@abstract func _send_data(data: PackedByteArray) -> void
