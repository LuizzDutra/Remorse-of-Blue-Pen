extends Node2D


var projectile_pack = load("res://Scenes/Projectile.tscn")

export var speed = 1000
export var pen_type = 0
export var damage = 10
export var penetration = 10


func create_projectile(parent_area: Area2D):
	var proj =projectile_pack.instance()
	proj.velocity = global_position.direction_to(get_global_mouse_position()) * speed
	proj.global_position = global_position
	proj.pen_type = pen_type
	proj.damage = damage
	proj.penetration = penetration
	proj.parent_area = parent_area
	get_tree().root.get_node("Game").add_child(proj)