class_name UDPSender extends SenderInterface

var socket: PacketPeerUDP
var port: int = 12345
var ip_address: String = "127.0.0.1"

func _ready() -> void:
	ip_address = ArgsParser.kwargs.get("python_host", "127.0.0.1")
	port =  int(ArgsParser.kwargs.get("observation_receiver_port", port))
	socket = PacketPeerUDP.new()
	var result = socket.set_dest_address(ip_address, port)
	if result != OK:
		DebugLogger.error("Failed to set destination address")
	else:
		DebugLogger.info("UDP Socket initialized to target %s:%d and ready to send data" % [ip_address, port])

func _send_data(data: PackedByteArray) -> void:
	var send_result: int = socket.put_packet(data)
	if send_result != OK:
		DebugLogger.error("Failed to send data")
	else:
		DebugLogger.debug("Data sent")
