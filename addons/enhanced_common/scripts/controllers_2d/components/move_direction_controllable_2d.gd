@icon("res://addons/enhanced_common/icons/icons8-left-and-right-arrows-24-blue.png")
extends Node2D
class_name RotationDirectionControllable2D

const DirectionType = Controller2D.DirectionType

@export var controller: Controller2D
@export var target: Node2D
@export var inverse_rotation: bool = false
@export var direction_type: DirectionType = DirectionType.MOVE:
	set(value):
		direction_type = value
		if controller == null:
			return
		_on_direction_changed(controller.get_direction(direction_type), direction_type)
# One shot sync
var single_sync: bool = false:
	set(value):
		single_sync = value
		is_synced = false 
var is_synced: bool = false 


func _ready() -> void:
	controller.direction_changed.connect(_on_direction_changed)

func _on_direction_changed(direction: Vector2, type: DirectionType) -> void:
	if direction_type != type or (single_sync == true and is_synced == false):
		return
	
	is_synced = true 
	target.scale.x = -1 if get_orientation_from_direction(direction) else 1

func get_orientation_from_direction(direction: Vector2) -> bool:
	return direction.x > 0 if inverse_rotation else direction.x < 0
	

func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []

	if controller == null:
		warnings.append("RotationDirectionControllable2D must have a controller configured.")
	
	if controller == null:
		warnings.append("RotationDirectionControllable2D must have a target to apply rotation to.")

	return warnings
