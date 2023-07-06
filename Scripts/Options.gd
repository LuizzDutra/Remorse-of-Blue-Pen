extends Control

@onready var sound_button = get_node("/root/ButtonSound")

signal options_return


func _ready():
	$GridContainer/MasterSlider.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	$GridContainer/MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	$GridContainer/SFXSlider.value = db_to_linear(AudioServer.get_bus_volume_db(2))
	$GridContainer/FullScreenBox.button_pressed = ((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN))

func _input(event):
	if event.is_action("ui_cancel"):
		if event.is_pressed() and visible:
			emit_signal("options_return")
			get_viewport().set_input_as_handled()

func _on_ReturnButton_pressed():
	sound_button.load_and_play(sound_button.press_sound)
	emit_signal("options_return")


func _on_ReturnButton_focus_entered():
	sound_button.load_and_play(sound_button.hover_sound)


func _on_ReturnButton_mouse_entered():
	sound_button.load_and_play(sound_button.hover_sound)


func _on_MasterSlider_value_changed(value):
	AudioServer.set_bus_volume_db(0, linear_to_db(value))


func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(1, linear_to_db(value))


func _on_SFXSlider_value_changed(value):
	AudioServer.set_bus_volume_db(2, linear_to_db(value))


func _on_FullScreenBox_toggled(button_pressed):
	get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (button_pressed) else Window.MODE_WINDOWED

