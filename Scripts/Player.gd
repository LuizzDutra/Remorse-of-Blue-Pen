extends KinematicBody2D


onready var gun = $Gun


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

func _ready():
	pass


func _physics_process(delta):
	if is_on_floor():
		jump_able = true

	dir.x = r_input - l_input

	if dir.x != 0:
		facing = dir.x

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
			gun.get_node("Receiver").create_projectile()
