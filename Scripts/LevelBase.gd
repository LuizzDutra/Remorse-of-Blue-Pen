extends Node2D


signal reset

func _on_Player_died():
	emit_signal("reset")
