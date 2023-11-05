extends RefCounted
class_name NodeBinding

var source_class
var bind_class
var bind: Callable

func _init(_source_class, _bind_class, to_bind: Callable) -> void:
	source_class = _source_class
	bind_class = _bind_class
	bind = to_bind

func request_bind(node: Node) -> void:
	if !is_instance_of(node, source_class):
		return
	
	if !node.is_node_ready():
		return node.ready.connect(_bind.bind(node), CONNECT_ONE_SHOT)
	
	_bind(node)

func _bind(source: Node) -> void:
	for node in NodeUtils.find_nodes(source, bind_class, source_class): 
		bind.call(source, node)	
	