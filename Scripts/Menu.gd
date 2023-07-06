extends Control


signal start_game
signal options_pressed

@onready var button_sound = get_node("/root/ButtonSound")

func _ready():
	$GridContainer/StartButton.grab_focus()

func _on_StartButton_pressed():
	emit_signal("start_game")
	button_sound.load_and_play(button_sound.press_sound)

func _on_OptionButton_pressed():
	emit_signal("options_pressed")
	button_sound.load_and_play(button_sound.press_sound)


func _on_ExitButton_pressed():
	get_tree().quit()

func _on_StartButton_focus_entered():
	button_sound.load_and_play(button_sound.hover_sound)
	
func _on_StartButton_mouse_entered():
	button_sound.load_and_play(button_sound.hover_sound)


func _on_ExitButton_focus_entered():
	button_sound.load_and_play(button_sound.hover_sound)


func _on_ExitButton_mouse_entered():
	button_sound.load_and_play(button_sound.hover_sound)


func _on_OptionButton_focus_entered():
	button_sound.load_and_play(button_sound.hover_sound)


func _on_OptionButton_mouse_entered():
	button_sound.load_and_play(button_sound.hover_sound)



