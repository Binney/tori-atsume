extends Area2D


export var min_speed = 150  # Minimum speed range.
export var max_speed = 250  # Maximum speed range.

export var lifetime = 60
export var point = 0

var flight_speed = 15
var age = 0
var arriving = true
var departing = false

func _ready():
	pass

func tweet():
	# TODO actually make a noise
	print("TWIET")

func set_flightpath(path):
	$BurdPath.set_curve(path)
	print($BurdPath/BurdPathFollow.position)

func tick():
	age += 1
	$BurdPath/BurdPathFollow.offset += flight_speed
	$BurdPath/BurdPathFollow/AnimatedSprite.rotation = PI
	print($BurdPath/BurdPathFollow.position)
	#	flightpath.offset += 5
#	position = flightpath.position
	if age > lifetime:
		depart()

func _on_VisibilityNotifier2D_viewport_entered(viewport):
	print("Spawned")

func arrive():
	print("Arriving")
	arriving = true

func depart():
	print("Departing")
	departing = true

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
