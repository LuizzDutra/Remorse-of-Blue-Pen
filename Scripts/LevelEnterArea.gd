extends Area2D
class_name level_enter_area

signal level_entered(level_path)

export var this_path = "res://Scenes/Levels/Level1.tscn"
export var level_name = "Level 1" setget set_label_name

var ident = 0

func interact():
	emit_signal("level_entered", this_path)

func set_label_name(n):
	$Label.text = n