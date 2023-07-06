extends Control

@onready var button_sound = get_node("/root/ButtonSound")

signal restart
signal options

func set_visibility(vis:bool, in_level: bool):
	visible = vis
	if visible:
		$GridContainer/Restart.grab_focus()
	
	if in_level:
		$GridContainer/OptionsButton.focus_neighbor_bottom = "../BackToHub"
		$GridContainer/BackToMenu.focus_neighbor_top = "../BackToHub"
		$GridContainer/BackToHub.visible = true
	else:
		$GridContainer/OptionsButton.focus_neighbor_bottom = "../BackToMenu"
		$GridContainer/BackToMenu.focus_neighbor_top = "../OptionsButton"
		$GridContainer/BackToHub.visible = false

func _input(event):
	if event.is_action("ui_cancel"):
		if event.is_pressed() and visible:
			get_tree().paused = false
			visible = false
			get_viewport().set_input_as_handled()

func _on_BackToMenu_pressed():
	button_sound.load_and_play(button_sound.press_sound)
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Base.tscn")


func _on_BackToHub_pressed():
	button_sound.load_and_play(button_sound.press_sound)
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	

func _on_Restart_pressed():
	button_sound.load_and_play(button_sound.press_sound)
	visible = false
	get_tree().paused = false
	emit_signal("restart")

func _on_OptionsButton_pressed():
	button_sound.load_and_play(button_sound.press_sound)
	emit_signal("options")


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



func _on_OptionsButton_focus_entered():
	button_sound.load_and_play(button_sound.hover_sound)

func _on_OptionsButton_mouse_entered():
	button_sound.load_and_play(button_sound.hover_sound)


func _on_Button_pressed():
	get_tree().paused = false
	visible = false
