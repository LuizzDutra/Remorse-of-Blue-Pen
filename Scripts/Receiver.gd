extends Node2D


var projectile_pack = load("res://Scenes/Projectile.tscn")

export var speed = 200
export var pen_type = 0


func create_projectile():
	var proj =projectile_pack.instance()
	proj.velocity = global_position.direction_to(get_global_mouse_position()) * speed
	proj.global_position = global_position
	get_tree().root.get_node("Game").add_child(proj)