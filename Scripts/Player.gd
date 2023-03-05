extends KinematicBody2D


onready var gun = $Gun
onready var interaction_area = $InteractionArea

export var health = 100 setget set_health
var dead = false

#movement variables
var dir: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO
export var acceleration: float = 1200
export var friction: float = 600
export var max_speed: float = 300
export var gravity: float = 9.8
export var jump_force = 5

var meter_unit = 64

var l_input = 0
var r_input = 0
var jump_input = false
var shoot_input = false

var jump_able = false

var facing = 1

var team = "player"

func _physics_process(delta):
	if is_on_floor():
		jump_able = true
	else:
		jump_able = false

	dir.x = r_input - l_input

	facing = global_position.direction_to(get_global_mouse_position()).normalized().x
	if facing > 0:
		facing = ceil(facing)
	elif facing < 0:
		facing = floor(facing)
	elif facing == 0:
		facing = 1

	$Body.rect_scale.x = facing

	velocity.y += gravity * meter_unit * delta
	velocity += dir * acceleration * delta

	velocity = velocity.move_toward(Vector2(0, velocity.y), friction*delta) 
	
	if velocity.x > max_speed:
		velocity = velocity.move_toward(Vector2(max_speed, velocity.y), acceleration*delta)
	if velocity.x < -max_speed:
		velocity = velocity.move_toward(Vector2(-max_speed, velocity.y), acceleration*delta)

	
	if jump_input and jump_able:
		velocity.y = -jump_force * meter_unit
		jump_able = false

	velocity = move_and_slide(velocity, Vector2.UP)

	


func _unhandled_input(event):
	if event.is_action("move_right"):
		if event.is_pressed():
			r_input = 1
		else:
			r_input = 0
	if event.is_action("move_left"):
		if event.is_pressed():
			l_input = 1
		else:
			l_input = 0
	if event.is_action("jump"):
		if event.is_pressed():
			jump_input = true
		else:
			jump_input = false
	
	if event.is_action("shoot"):
		if event.is_pressed():
			gun.get_node("Receiver").create_projectile(team, get_global_mouse_position())
	
	if event.is_action("interact"):
		if event.is_pressed():
			interact_process()


func _on_HurtBox_got_hit(dam, _pen):
	set_health(health - dam)


func set_health(value):
	health = value
	if health <= 0:
		dead = true

func interact_process():#interaction
	var interact_q_0 = []
	var interact_q_1 = []
	for area in interaction_area.get_overlapping_areas():
		print(area)
		if area.ident == 0:
			interact_q_0.append(area)
		if area.ident == 1:
			interact_q_1.append(area)
	if len(interact_q_0) > 0:
		interact_q_0[0].interact()
	elif len(interact_q_1) > 0:
		interact_q_1[0].interact()
