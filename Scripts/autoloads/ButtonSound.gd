extends AudioStreamPlayer

var press_sound = load("res://Assets/Sounds/buttontest.wav")
var hover_sound = load("res://Assets/Sounds/buttonhovertest.wav")

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	bus = "SFX"
	stream = press_sound

func load_and_play(sound):
	stream = sound
	play()
