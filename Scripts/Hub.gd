extends Node

signal level_entered(loaded_level)
signal reset

func _ready():
	for area in $LevelAreas.get_children():
		area.connect("level_entered", self, "_on_LevelEnterArea_level_entered")


func _on_LevelEnterArea_level_entered(level_path):
	emit_signal("level_entered", load(level_path))


func _on_Player_died():
	emit_signal("reset")
