extends Node
# NodeBinder

var bindings: Array[NodeBinding] = []

func add_binding(binding: NodeBinding) -> void:
	bindings.append(binding)	

func remove_binding(binding: NodeBinding) -> void:
	bindings.erase(binding)	



func _enter_tree() -> void:
	get_tree().node_added.connect(_on_node_added)

func _on_node_added(node: Node) -> void:
	for binding in bindings:
		binding.request_bind(node)