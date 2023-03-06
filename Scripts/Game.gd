extends Node

var hub_scene = load("res://Scenes/Levels/Hub.tscn")

onready var menu = $CanvasLayer/GameMenu

func _on_Hub_level_entered(loaded_level):
	$Hub.queue_free()
	add_child(loaded_level.instance())

func _unhandled_input(event):
	if event.is_action("ui_cancel"):
		if event.is_pressed():
			if menu.visible:
				get_tree().paused = false
				menu.set_visibility(false, true)
			elif not menu.visible:
				get_tree().paused = true
				if has_node("Hub"):
					menu.set_visibility(true, false)
				else:
					menu.set_visibility(true, true)
				


func _on_BackToMenu_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Base.tscn")


func _on_BackToHub_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Game.tscn")


func _on_Return_pressed():
	menu.visible = false
	get_tree().paused = false
