class_name UDPSender extends SenderInterface 

var socket: PacketPeerUDP
var port: int = 12345
var ip_address: String = "127.0.0.1"

func _ready() -> void:
	var env = DotEnvReader.load_env("res://strategy_resource_rl/.env")
	ip_address = env.get("PYTHON_HOST", "127.0.0.1")
	port = int(env.get("OBSERVATION_RECEIVER_PORT", "12345"))
	socket = PacketPeerUDP.new()
	var result = socket.set_dest_address(ip_address, port)
	if result != OK:
		push_error("Failed to set destination address")
	else:
		print("UDP Socket initialized and ready to send data")

func _send_data(data: PackedByteArray) -> void:
	var send_result: int = socket.put_packet(data)
	if send_result != OK:
		push_error("Failed to send data")
	else:
		print("Data sent")
