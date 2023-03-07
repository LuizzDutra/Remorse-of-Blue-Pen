extends Area2D
class_name HurtBox

signal got_hit(dam, pen)

var team = "None"

func hit(damage: float, penetration: float, hit_position):
	emit_signal("got_hit", damage, penetration, hit_position)
