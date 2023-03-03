extends Node2D


func _physics_process(_delta):
	rotation = get_global_mouse_position().angle_to_point(global_position)

