extends AudioStreamPlayer

var press_path = "res://Assets/Sounds/select.mp3"
var hover_path = "res://Assets/Sounds/preselect.mp3"

var press_sound = load(press_path)
var hover_sound = load(hover_path)

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	bus = "SFX"
	stream = press_sound

func load_and_play(sound):
	#gives preference to the press_sound
	if playing and stream.resource_path == press_path:
		return
	stream = sound
	play()
