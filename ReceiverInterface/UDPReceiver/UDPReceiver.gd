class_name UDPReceiver extends ReceiverInterface

var socket: PacketPeerUDP
var port: int = 12345
var ip_address: String = "127.0.0.1"

func _ready() -> void:
	ip_address = ArgsParser.kwargs.get("godot_host", "127.0.0.1")
	port = int(ArgsParser.kwargs.get("action_receiver_port", port))
	socket = PacketPeerUDP.new()
	var result = socket.bind(port, ip_address)
	if result != OK:
		DebugLogger.error("Failed to start UDP server")
	else:
		DebugLogger.info("UDP Server started and listening on %s:%d" % [ip_address, port])

func get_data() -> PackedByteArray:
	while is_inside_tree() and socket.get_available_packet_count() == 0:
		await get_tree().process_frame

	var packet = socket.get_packet()
	DebugLogger.trace("Data received: " + str(packet))
	return packet
