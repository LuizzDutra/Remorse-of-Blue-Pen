extends AudioStreamPlayer

var press_sound = load("res://Assets/Sounds/select.mp3")
var hover_sound = load("res://Assets/Sounds/preselect.mp3")

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	bus = "SFX"
	stream = press_sound

func load_and_play(sound):
	stream = sound
	play()
