extends Node2D


func _physics_process(_delta):
	rotation = get_global_mouse_position().angle_to_point(global_position)
	if rotation_degrees > 90 or rotation_degrees < -90:
		$Arm.rect_scale.y = -1
	else:
		$Arm.rect_scale.y = 1
