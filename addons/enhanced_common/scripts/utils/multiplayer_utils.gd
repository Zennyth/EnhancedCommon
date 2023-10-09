extends Object
class_name MultiplayerUtils


static func get_running_instance_number() -> int:
	var _instance_socket: TCPServer 

	if not OS.is_debug_build():
		return -1
	
	_instance_socket = TCPServer.new()
	for n in range(0,4):
		if _instance_socket.listen(6008 + n) == OK:
			return n
	
	return -1
