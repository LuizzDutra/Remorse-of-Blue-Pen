extends Node

var tree_timer: SceneTreeTimer

func slowdown(duration, time_scale):
	Engine.time_scale = time_scale
	tree_timer = get_tree().create_timer(duration*time_scale, false)
	var tree_timer_ref = tree_timer
	yield(tree_timer, "timeout")
	if tree_timer == tree_timer_ref:
		Engine.time_scale = 1
