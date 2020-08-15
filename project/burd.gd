extends Area2D


export var min_speed = 150  # Minimum speed range.
export var max_speed = 250  # Maximum speed range.

export var lifetime = 60

var age = 0

func _ready():
	pass

func tweet():
	# TODO actually  make a noise
	print("TWIET")

func tick():
	age += 1
	if age > lifetime:
		depart()

func arrive():
	print("Arriving");

func depart():
	print("Departing");

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
