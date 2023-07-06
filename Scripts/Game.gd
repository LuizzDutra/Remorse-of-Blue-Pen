extends Node

var hub_scene = load("res://Scenes/Levels/Hub.tscn")

@onready var menu = $CanvasLayer/GameMenu

var cur_level = null
var cur_level_pack = null

func _on_Hub_level_entered(loaded_level):
	$Hub.queue_free()
	cur_level_pack = loaded_level
	cur_level = loaded_level.instantiate()
	add_child(cur_level)
	cur_level.connect("reset", Callable(self, "_on_reset"))

func _unhandled_input(event):
	if event.is_action("ui_cancel"):
		if event.is_pressed():
			if not menu.visible:
				get_tree().paused = true
				if has_node("Hub"):
					menu.set_visibility(true, false)
				else:
					menu.set_visibility(true, true)
		get_viewport().set_input_as_handled()
				

func _on_GameMenu_restart():
	if has_node("Hub"):
		get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	else:
		remove_child(cur_level)
		cur_level = cur_level_pack.instantiate()
		add_child(cur_level)
		cur_level.connect("reset", Callable(self, "_on_reset"))

func _on_reset():
	_on_GameMenu_restart()


func _on_GameMenu_options():
	get_tree().paused = true
	$CanvasLayer/GameMenu.visible = false
	$CanvasLayer/Options.visible = true
	$CanvasLayer/Options/ReturnButton.grab_focus()


func _on_Options_options_return():
	get_tree().paused = true
	if has_node("Hub"):
		menu.set_visibility(true, false)
	else:
		menu.set_visibility(true, true)
	$CanvasLayer/Options.visible = false
