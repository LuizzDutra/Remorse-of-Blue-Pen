extends KinematicBody2D


onready var gun = $Gun
onready var interaction_area = $InteractionArea
onready var slowdown = get_node("/root/Slowdown")

export var health = 1 setget set_health
var dead = false
signal died

#movement variables
var dir: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO
export var acceleration: float = 3600
export var friction: float = 1800
export var max_speed: float = 600
export var max_vertical_speed: float = 800
export var gravity: float = 9.8 * 4
export var jump_force = 15
export var dash_mult = 1.25
export var dash_x_mult = 1.5
export var dash_y_mult = 0.75
var meter_unit = 32

var l_input = 0
var r_input = 0
var d_input = 0
var jump_input = 0
var shoot_input = false

var jump_able = false
var dash_able = true
var dashing = false

var facing = 1

var parry_able = false

func _ready():
	$HurtBox.team = "player"

func _physics_process(delta):
	
	if is_on_floor():
		jump_able = true
		dash_able = true
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

	#Sprites code
	if not dead:
		$Body.scale.x = facing
		$Arm.scale.x = facing
		$Arm.rotation = (get_global_mouse_position() - global_position).angle()
		$Arm.position.x = abs($Arm.position.x) * -facing
		$Arm.rotation -= deg2rad(90)
	
	
	velocity.y += gravity * meter_unit * delta
	if not dead:
		velocity += dir * acceleration * delta

	velocity = velocity.move_toward(Vector2(0, velocity.y), friction*delta) 
	
	if velocity.x > max_speed:
		velocity = velocity.move_toward(Vector2(max_speed, velocity.y), acceleration*delta)
	if velocity.x < -max_speed:
		velocity = velocity.move_toward(Vector2(-max_speed, velocity.y), acceleration*delta)
	if velocity.y > max_vertical_speed:
		velocity = velocity.move_toward(Vector2(velocity.x, max_vertical_speed), acceleration*delta)
	if velocity.y < -max_vertical_speed:
		velocity = velocity.move_toward(Vector2(velocity.x, -max_vertical_speed), acceleration*delta)

	
	if jump_input == 1 and jump_able and not dead:
		velocity.y = -jump_force * meter_unit
		jump_able = false

	if dashing and not dead:
		velocity = Vector2(r_input - l_input, d_input - jump_input) * max_speed
		velocity *= dash_mult
		velocity.x *= dash_x_mult
		velocity.y *= dash_y_mult
		dashing = false
		dash_able = false
		$DashTimer.start()
		
	#parry
	if parry_able and not dead:
		parry()

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
			jump_input = 1
		else:
			jump_input = 0
	
	if event.is_action("move_down"):
		if event.is_pressed():
			d_input = 1
		else:
			d_input = 0
	
	if event.is_action("shoot"):
		if event.is_pressed():
			shoot()
	
	if event.is_action_pressed("dash"):
		if dash_able and $DashTimer.is_stopped():
			dashing = true
	
	if event.is_action("interact"):
		if event.is_pressed() and not dead:
			interact_process()
	
	if event.is_action("parry"):
		if event.is_pressed() and $ParryTimer.is_stopped() and $ParryDurationTimer.is_stopped():
			parry_able = true
			$ParryDurationTimer.start()
		

func parry():
	var parry_success = false
	for area in $ParryArea.get_overlapping_areas():
		if area.get_parent() != null and area.get_parent().has_method("parry"):
			area.get_parent().parry("player")
			parry_success = true
	if parry_success:
		$ParryDurationTimer.stop()
		$ParryTimer.stop()
		parry_able = false
		slowdown.slowdown(0.5, 0.075)

func shoot():
	if $ShootTimer.is_stopped() and not dead:
		gun.get_node("Receiver").create_projectile($HurtBox.team, get_global_mouse_position())
		$ShootTimer.start()

func _on_HurtBox_got_hit(dam, _pen, hit_position: Vector2):
	set_health(health - dam)
	$hit_sound.play()
	$hit_sound_impact.play()
	knockback(hit_position.direction_to(global_position), 2)
	slowdown.slowdown(0.8, 0.075)

func knockback(knock_dir, knock_intensity):
	velocity.x = knock_dir.x * 1000 * knock_intensity
	velocity.y = -150 * knock_intensity
	#print(velocity)

func set_health(value):
	health = value
	if health <= 0:
		dead = true
		death_process()

func death_process():
	$HurtBox.set_deferred("monitorable", false)
	$DetectArea.collision_layer = false
	$InteractionArea.set_deferred("monitorable", false)
	$DeathResetTimer.start()

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


func _on_DeathResetTimer_timeout():
	emit_signal("died")


func _on_ParryDurationTimer_timeout():
	parry_able = false
	$ParryTimer.start()
