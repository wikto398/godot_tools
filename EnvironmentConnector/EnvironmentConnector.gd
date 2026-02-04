class_name EnvironmentConnector extends Node

@onready var receiver: ReceiverInterface = $Receiver
@onready var sender: SenderInterface = $Sender

func _ready() -> void:
	print("EnvironmentConnector is ready")
	wait_for_ready()

func wait_for_ready() -> void:
	print("EnvironmentConnector is ready to start communication")
	var received_data: PackedByteArray = "".to_utf8_buffer()
	while received_data.get_string_from_utf8() != "TRAINER_READY":
		received_data= await receiver.wait_for_data()
	var data_to_send: PackedByteArray = "ENV_READY".to_utf8_buffer()
	sender.send_data(data_to_send)
	while received_data.get_string_from_utf8() != "START_TRAINING":
		received_data= await receiver.wait_for_data()
	start_communication()

func start_communication() -> void:
	var received_data: PackedByteArray 
	var data_to_send: PackedByteArray 
	while true:
		data_to_send = "dummy_data".to_utf8_buffer()
		sender.send_data(data_to_send)
		# Process received_data as needed
		received_data = await receiver.wait_for_data()
		_handle_received_data(received_data)

func _handle_received_data(data: PackedByteArray) -> void:
	print("Handling received data: ", data)
	# Implement data handling logic here
