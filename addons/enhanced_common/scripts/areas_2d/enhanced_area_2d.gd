extends Area2D
class_name EnhancedArea2D

signal _node_entered(node: Node2D)
signal _area_entered(area: Area2D)
signal _body_entered(body: Node2D)


var components: Array[EnhancedArea2DComponent] = []

func register_component(component: EnhancedArea2DComponent) -> void:
	components.append(component)


func is_node_entered_valid(node: Node2D) -> bool:
	for component in components:
		if !component.is_node_entered_valid(node):
			return false
	
	return true

func _init():
	area_entered.connect(_on_area_entered)
	body_entered.connect(_on_body_entered)


func _on_area_entered(area: Area2D) -> void:
	if !is_node_entered_valid(area):
		return

	_area_entered.emit(area)
	_node_entered.emit(area)

func _on_body_entered(body: Node2D) -> void:
	if !is_node_entered_valid(body):
		return

	_body_entered.emit(body)
	_node_entered.emit(body)



@onready var collision_shape = $CollisionShape2D

func disable() -> void:
	collision_shape.disabled = true

func enable() -> void:
	collision_shape.disabled = false