extends Motion2D
class_name ProjectileMotion2D

@export var target: Node2D

func _physics_process(delta: float) -> void:
	target.rotation = direction.angle()
	target.position += direction * speed * delta