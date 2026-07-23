class_name EnvironmentConnector extends Node

@onready var receiver: ReceiverInterface = $Receiver
@onready var sender: SenderInterface = $Sender
@onready var observation_collector: ObservationCollector = $ObservationCollector
@onready var action_executor: ActionExecutorInterface = $ActionExecutor

var data: Dictionary
var communicating: bool = false

func _ready() -> void:
	DebugLogger.info("EnvironmentConnector is ready")
	if not Global.connected_to_trainer:
		wait_for_ready()
	else:
		DebugLogger.info("Already connected to trainer, starting communication")
		start_communication()

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
	Global.connected_to_trainer = true
	start_communication()

func start_communication() -> void:
	var received_data: PackedByteArray
	var data_to_send: PackedByteArray
	DebugLogger.info("Starting communication with trainer...")
	communicating = true
	while communicating:
		data_to_send = Messagepack.encode(observation_collector.get_observation())["value"]
		sender.send_data(data_to_send)
		received_data = await receiver.wait_for_data()
		_handle_received_data(received_data)

func _handle_received_data(received_data: PackedByteArray) -> void:
	DebugLogger.debug("Handling received data: " + str(received_data))
	var msg := received_data.get_string_from_utf8()

	if msg.begins_with("RESET"):
		var parts := msg.split(":")
		if parts.size() > 1:
			Global.map_seed = int(parts[1])
			Global.map_seed_valid = true
			DebugLogger.info("RESET with map_seed=%d" % Global.map_seed)
		else:
			Global.map_seed_valid = false
			DebugLogger.info("RESET without seed (randomize map)")
		reset_environment()
		return

	action_executor.execute_action(received_data)

func reset_environment() -> void:
	DebugLogger.info("Received RESET command. Resetting environment.")
	sender.send_data("RESET_ACK".to_utf8_buffer())
	communicating = false
	Global.reset_environment()
