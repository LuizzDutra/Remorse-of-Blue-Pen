extends ParallaxLayer


export var speed = 10


func _process(delta):
	motion_offset.x -= speed*delta
