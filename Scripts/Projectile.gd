extends KinematicBody2D

var team = "None"

var velocity: Vector2 = Vector2.ZERO
var pen_type: int = 0

var damage = 10
var penetration = 10

var entered_bodies: Array = []

func _physics_process(delta):
	var collider = move_and_collide(velocity * delta)
	if collider:
		queue_free()

func parry(parrier_team):
	velocity *= -1
	team = parrier_team
	#queue_free()

func _on_ProjArea_area_entered(area:Area2D):
	if not area in entered_bodies and area.team != team:
		entered_bodies.append(area)
		if area.name == "HurtBox":
			area.hit(damage, penetration, global_position)
		match pen_type:
			0:
				queue_free()
			1:
				damage *= 0.5
				velocity *= 0.75
				pen_type = 0
			2:
				damage *= 0.75
				velocity *= 0.85
				pen_type = 1

func _on_ProjArea_area_exited(area:Area2D):
	if area in entered_bodies:
		entered_bodies.erase(area)
