extends Control


signal start_game

onready var button_sound = get_node("/root/ButtonSound")

var loaded = false

func _ready():
	$GridContainer/StartButton.grab_focus()
	loaded = true


func _on_StartButton_pressed():
	emit_signal("start_game")
	button_sound.load_and_play(button_sound.press_sound)

func _on_ExitButton_pressed():
	get_tree().quit()

func _on_StartButton_focus_entered():
	if loaded:
		button_sound.load_and_play(button_sound.hover_sound)
	
func _on_StartButton_mouse_entered():
	if loaded:
		button_sound.load_and_play(button_sound.hover_sound)


func _on_ExitButton_focus_entered():
	if loaded:
		button_sound.load_and_play(button_sound.hover_sound)


func _on_ExitButton_mouse_entered():
	if loaded:
		button_sound.load_and_play(button_sound.hover_sound)
