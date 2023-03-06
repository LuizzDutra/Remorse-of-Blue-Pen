extends Control


func set_visibility(vis:bool, in_level: bool):
	visible = vis
	if visible:
		$GridContainer/Return.grab_focus()
	
	if in_level:
		$GridContainer/Return.focus_neighbour_bottom = "../BackToHub"
		$GridContainer/BackToMenu.focus_neighbour_top = "../BackToHub"
		$GridContainer/BackToHub.visible = true
	else:
		$GridContainer/Return.focus_neighbour_bottom = "../BackToMenu"
		$GridContainer/BackToMenu.focus_neighbour_top = "../Return"
		$GridContainer/BackToHub.visible = false
