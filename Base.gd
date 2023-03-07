extends Node

func _on_Menu_start_game():
	print(get_tree().change_scene("res://Scenes/Game.tscn"))


func _on_Menu_options_pressed():
	$Menu.visible = false
	$Options.visible = true
	$Options/ReturnButton.grab_focus()


func _on_Options_options_return():
	$Menu.visible = true
	$Options.visible = false
	$Menu/GridContainer/StartButton.grab_focus()
