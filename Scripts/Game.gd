extends Node

var hub_scene = load("res://Scenes/Levels/Hub.tscn")

onready var menu = $CanvasLayer/Menu

func _on_Hub_level_entered(loaded_level):
	$Hub.queue_free()
	add_child(loaded_level.instance())


func _unhandled_input(event):
	if event.is_action("ui_cancel"):
		if event.is_pressed():
			if menu.visible:
				menu.visible = false
			elif not menu.visible:
				menu.visible = true
				if has_node("Hub"):
					menu.get_node("GridContainer/BackToHub").visible = false
				else:
					menu.get_node("GridContainer/BackToHub").visible = true


func _on_BackToMenu_pressed():
	get_tree().change_scene("res://Base.tscn")


func _on_BackToHub_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")


func _on_Return_pressed():
	menu.visible = false
