extends Motion2D
class_name CharacterBodyMotion2D

const FRICTION 		:= -1

@export var target					: CharacterBody2D

func _physics_process(delta: float) -> void:
	target.velocity = target.velocity.move_toward(direction * speed, FRICTION * delta) if FRICTION > -1 else direction * speed

	for force in get_forces():
		target.velocity += force

	target.move_and_slide()

func disable() -> void:
	super()
	target.velocity = Vector2.ZERO