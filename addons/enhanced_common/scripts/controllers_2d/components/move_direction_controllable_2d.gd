@icon("res://addons/enhanced_common/icons/icons8-left-and-right-arrows-24-blue.png")
extends Node2D
class_name RotationDirectionControllable2D

enum Mode {
	MOVE,
	AIM,
}

@export var controller: Controller2D
@export var target: Node2D
@export var inverse_rotation: bool = false
@export var mode: Mode = Mode.MOVE

func _ready() -> void:
	controller.moving.connect(_on_moving)
	controller.aim_direction_changed.connect(_on_aim_direction_changed)

func _on_moving() -> void:
	if mode != Mode.MOVE:
		return

	target.scale.x = -1 if get_orientation_from_direction(controller.move_direction) else 1

func _on_aim_direction_changed(_direction: Vector2) -> void:
	if mode != Mode.AIM:
		return
	
	target.scale.x = -1 if get_orientation_from_direction(controller.aim_direction) else 1

func get_orientation_from_direction(direction: Vector2) -> bool:
	return direction.x > 0 if inverse_rotation else direction.x < 0


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []

	if controller == null:
		warnings.append("RotationDirectionControllable2D must have a controller configured.")
	
	if controller == null:
		warnings.append("RotationDirectionControllable2D must have a target to apply rotation to.")

	return warnings
