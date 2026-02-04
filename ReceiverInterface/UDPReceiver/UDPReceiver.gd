class_name UDPReceiver extends ReceiverInterface 

var socket: PacketPeerUDP 
var port: int = 12345
var ip_address: String = "127.0.0.1"

func _ready() -> void:
	var env = DotEnvReader.load_env("res://strategy_resource_rl/.env")
	ip_address = env.get("GODOT_HOST", "127.0.0.1")
	port = int(env.get("ACTION_RECEIVER_PORT", "12345"))
	socket = PacketPeerUDP.new()
	var result = socket.bind(port, ip_address)
	if result != OK:
		push_error("Failed to start UDP server")
	else:
		print("UDP Server started and listening on %s:%d" % [ip_address, port])

func get_data() -> PackedByteArray:
	while socket.get_available_packet_count() == 0:
		await get_tree().process_frame
	var packet = socket.get_packet()
	return packet
