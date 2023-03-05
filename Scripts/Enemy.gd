extends KinematicBody2D

onready var detect_cast = $DetectionCast
onready var player = get_parent().get_node("Player")
onready var gun = $EnemyGun
onready var shoot_timer = $ShootTimer

var dead = false

export var health = 100 setget set_health
export var armor = 10
export var speed = 200

enum {IDLE_STATE, ATTENTION_STATE, ALERT_STATE, ATTACK_STATE}

var State = IDLE_STATE

func _ready():
	detect_cast.target = player
	detect_cast.target_bottom = player.get_node("bottom")
	detect_cast.target_top = player.get_node("top")
	$HurtBox.team = "enemy"

func _physics_process(delta):
	if dead:
		queue_free()

	detect_cast.calculate_cast_scan(delta)

	match State:
		IDLE_STATE:
			idle_routine()
		ATTENTION_STATE:
			attention_routine()
		ALERT_STATE:
			alert_routine()
		ATTACK_STATE:
			attack_routine()


func idle_routine():
	if detect_cast.detecting_target:
		State = ALERT_STATE

func attention_routine():
	if detect_cast.detecting_target:
		State = ATTACK_STATE
		$AttentionTimer.stop()
	elif $AttentionTimer.is_stopped():
		$AttentionTimer.start()
	
func alert_routine():
	detect_cast.facing = 2
	if detect_cast.detecting_target:
		State = ATTACK_STATE
		$AlertTimer.stop()
	elif $AlertTimer.is_stopped():
		$AlertTimer.start()
		

func attack_routine():
	detect_cast.facing = 2
	if not detect_cast.detecting_target:
		State = ALERT_STATE
	if shoot_timer.is_stopped():
		shoot()
		shoot_timer.start()


func shoot():
	gun.get_node("Receiver").create_projectile($HurtBox.team, detect_cast.target_last_seen_pos)


func _on_HurtBox_got_hit(dam, pen):
	var resulting_damage = dam - (armor - pen)
	set_health(health - resulting_damage)


func set_health(value):
	health = value
	if health <= 0:
		dead = true

func _on_ShootTimer_timeout():
	pass # Replace with function body.


func _on_AlertTimer_timeout():
	State = ATTENTION_STATE
	detect_cast.facing = int(ceil(detect_cast.target_last_seen_pos.normalized().x))
	


func _on_IdleTimer_timeout():
	pass # Replace with function body.


func _on_AttentionTimer_timeout():
	State = IDLE_STATE