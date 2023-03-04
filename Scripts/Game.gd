extends Node

var hub_scene = load("res://Scenes/Levels/Hub.tscn")

func _on_Hub_level_entered(loaded_level):
	$Hub.queue_free()
	add_child(loaded_level.instance())


func _unhandled_input(event):
	if event.is_action("ui_cancel"):
		if event.is_pressed() and not has_node("Hub"):
			for i in get_children():
				i.queue_free()
			var hub = hub_scene.instance()
			add_child(hub)
			hub.connect("level_entered", self, "_on_Hub_level_entered")