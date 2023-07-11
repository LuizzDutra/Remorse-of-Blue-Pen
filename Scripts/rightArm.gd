extends Bone2D


@export var skeleton: Skeleton2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation = get_global_mouse_position().angle_to_point(global_position)
	if skeleton.scale.x == -1:
		scale.x = -1
		scale.y = -1
		rotation *= -1
	else:
		scale.x = 1
		scale.y = 1
