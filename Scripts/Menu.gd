extends Control


signal start_game

func _ready():
	$GridContainer/StartButton.grab_focus()


func _on_StartButton_pressed():
	emit_signal("start_game")

func _on_ExitButton_pressed():
	get_tree().quit()
