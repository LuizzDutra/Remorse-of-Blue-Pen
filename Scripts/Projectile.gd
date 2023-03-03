extends KinematicBody2D


var velocity = Vector2.ZERO

func _physics_process(delta):
	var collider = move_and_collide(velocity * delta)
	if collider:
		queue_free()