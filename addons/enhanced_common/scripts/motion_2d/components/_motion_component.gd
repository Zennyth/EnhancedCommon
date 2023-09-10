@tool
@icon("res://assets/icons/materials/forward_icon.png")
extends Node
class_name Motion2DComponent

@onready var motion: Motion2D = get_parent():
    set = set_motion



func set_motion(value) -> void:
    motion = value
    update_configuration_warnings()

func _get_configuration_warnings() -> PackedStringArray:
    var warnings: PackedStringArray = []

    if not get_parent() is Motion2D:
        warnings.append("This node is not a child of a State node.")

    return warnings
