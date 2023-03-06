extends Node

var hub_scene = load("res://Scenes/Levels/Hub.tscn")

onready var menu = $CanvasLayer/GameMenu

var cur_level = null
var cur_level_pack = null

func _on_Hub_level_entered(loaded_level):
	$Hub.queue_free()
	cur_level_pack = loaded_level
	cur_level = loaded_level.instance()
	add_child(cur_level)

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
	if has_node("Hub"):
		get_tree().change_scene("res://Scenes/Game.tscn")
	else:
		remove_child(cur_level)
		cur_level = cur_level_pack.instance()
		add_child(cur_level)
	
