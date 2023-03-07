extends Control

onready var button_sound = get_node("/root/ButtonSound")

signal restart

func set_visibility(vis:bool, in_level: bool):
	visible = vis
	if visible:
		$GridContainer/Restart.grab_focus()
	
	if in_level:
		$GridContainer/Restart.focus_neighbour_bottom = "../BackToHub"
		$GridContainer/BackToMenu.focus_neighbour_top = "../BackToHub"
		$GridContainer/BackToHub.visible = true
	else:
		$GridContainer/Restart.focus_neighbour_bottom = "../BackToMenu"
		$GridContainer/BackToMenu.focus_neighbour_top = "../Restart"
		$GridContainer/BackToHub.visible = false

func _on_BackToMenu_pressed():
	button_sound.load_and_play(button_sound.press_sound)
	get_tree().paused = false
	get_tree().change_scene("res://Base.tscn")


func _on_BackToHub_pressed():
	button_sound.load_and_play(button_sound.press_sound)
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Game.tscn")


func _on_BackToHub_focus_entered():
	button_sound.load_and_play(button_sound.hover_sound)


func _on_BackToHub_mouse_entered():
	button_sound.load_and_play(button_sound.hover_sound)


func _on_BackToMenu_focus_entered():
	button_sound.load_and_play(button_sound.hover_sound)


func _on_BackToMenu_mouse_entered():
	button_sound.load_and_play(button_sound.hover_sound)


func _on_Restart_focus_entered():
	button_sound.load_and_play(button_sound.hover_sound)


func _on_Restart_mouse_entered():
	button_sound.load_and_play(button_sound.hover_sound)


func _on_Restart_pressed():
	button_sound.load_and_play(button_sound.press_sound)
	visible = false
	get_tree().paused = false
	emit_signal("restart")
