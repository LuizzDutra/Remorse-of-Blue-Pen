extends KinematicBody2D

var dead = false

export var health = 100 setget set_health
export var armor = 10
export var speed = 200

func _physics_process(_delta):
	if dead:
		queue_free()

func _on_HurtBox_got_hit(dam, pen):
	var resulting_damage = dam - (armor - pen)
	set_health(health - resulting_damage)


func set_health(value):
	health = value
	if health <= 0:
		dead = true