@tool
extends EditorPlugin

const ClassUtils = "ClassUtils"


func _enter_tree():
	add_autoload_singleton(ClassUtils, "res://addons/enhanced_common/scripts/utils/class_utils.gd")
	add_autoload_singleton("NodeBinder", "res://addons/enhanced_common/scripts/node_binders/node_binder.gd")


func _exit_tree():
	remove_autoload_singleton("NodeBinder")
	remove_autoload_singleton(ClassUtils)
