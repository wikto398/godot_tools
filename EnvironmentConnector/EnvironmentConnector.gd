class_name EnvironmentConnector extends Node

@onready var receiver: ReceiverInterface = $Receiver
@onready var sender: SenderInterface = $Sender
@onready var observation_collector: ObservationCollector = $ObservationCollector
@onready var action_executor: ActionExecutorInterface = $ActionExecutor
var data: Dictionary

func _ready() -> void:
	DebugLogger.info("EnvironmentConnector is ready")
	wait_for_ready()

func wait_for_ready() -> void:
	DebugLogger.info("EnvironmentConnector is ready to start communication")
	var received_data: PackedByteArray = "".to_utf8_buffer()
	var data_to_send: PackedByteArray = "ENV_READY".to_utf8_buffer()
	sender.send_data(data_to_send)
	while received_data.get_string_from_utf8() != "TRAINER_READY":
		received_data= await receiver.wait_for_data()
	sender.send_data("TRAINER_READY_ACK".to_utf8_buffer())
	while received_data.get_string_from_utf8() != "START_TRAINING":
		received_data= await receiver.wait_for_data()
	start_communication()

func start_communication() -> void:
	var received_data: PackedByteArray
	var data_to_send: PackedByteArray
	while true:
		data_to_send = Messagepack.encode(observation_collector.get_observation())["value"]
		sender.send_data(data_to_send)
		received_data = await receiver.wait_for_data()
		_handle_received_data(received_data)

func _handle_received_data(received_data: PackedByteArray) -> void:
	DebugLogger.debug("Handling received data: " + str(received_data))
	action_executor.execute_action(received_data)
