@icon("res://addons/enhanced_common/icons/icons8-puppet-24-blue.png")
extends Node2D
class_name Controller2D

enum DirectionType {
	MOVE,
	WATCH,
	AIM
}

signal direction_changed(direction: Vector2, direction_type: DirectionType)
signal move_direction_changed(direction: Vector2)
signal standing
signal moving

signal aim_direction_changed(direction: Vector2)


@export var directional_strength_threshold: float = .0
@export var is_controllable: bool = true



var move_direction: Vector2 = Vector2.ZERO:
	set = set_move_direction

func set_move_direction(value) -> void:
	if !is_controllable:
		value = Vector2.ZERO

	var has_changed: bool = move_direction != value
	move_direction = value

	if !has_changed:
		return
	
	move_direction_changed.emit(move_direction)
	direction_changed.emit(move_direction, DirectionType.MOVE)

	if is_above_threshold(move_direction) and is_controllable:
		moving.emit()
		watch_direction = move_direction
		direction_changed.emit(watch_direction, DirectionType.WATCH)
	else:
		standing.emit()

var watch_direction: Vector2 = Vector2.ZERO


var aim_direction: Vector2 = Vector2.ZERO:
	set = set_aim_direction

func set_aim_direction(value) -> void:
	if !is_controllable:
		return

	var has_changed: bool = aim_direction != value
	aim_direction = value

	if !has_changed:
		return
	
	aim_direction_changed.emit(aim_direction)
	direction_changed.emit(aim_direction, DirectionType.AIM)

func get_direction(direction_type: DirectionType) -> Vector2:
	match direction_type:
		DirectionType.MOVE:
			return move_direction
		DirectionType.WATCH:
			return watch_direction
		DirectionType.AIM:
			return aim_direction
		_:
			return Vector2.ZERO

func is_above_threshold(vector: Vector2) -> bool:
	return vector.length_squared() > directional_strength_threshold