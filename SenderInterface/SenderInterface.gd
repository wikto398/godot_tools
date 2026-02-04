@abstract
class_name SenderInterface extends Node

func send_data(data: PackedByteArray) -> void:
    print("Data for sending: ", data)
    _send_data(data)

@abstract func _send_data(data: PackedByteArray) -> void