@tool
@icon("res://addons/enhanced_common/icons/icons8-anchor-24.png")
extends Node2D
class_name Anchors2D

static func get_anchor_id_list() -> Array[String]:
	return []

func get_anchor(anchor_id: String) -> Node2D:
	return get(anchor_id) as Node2D

func get_anchors() -> Array[Node2D]:
	var anchors: Array[Node2D]

	for anchor_id in get_anchor_id_list():
		anchors.append(get_anchor(anchor_id))
	
	return anchors