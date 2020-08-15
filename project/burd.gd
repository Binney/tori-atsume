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
	if arriving:
		tick_arrive()
	elif departing:
		tick_depart()
	else:
		tick_hanging_out()

func tick_arrive():

	if ($BurdPath/BurdPathFollow.offset + flight_speed > $BurdPath.curve.get_baked_length()):
		arrive()
		return

	var old_x = $BurdPath/BurdPathFollow.position.x
	$BurdPath/BurdPathFollow.offset += flight_speed
	var new_x = $BurdPath/BurdPathFollow.position.x

	if (old_x > new_x):
		$BurdPath/BurdPathFollow/AnimatedSprite.transform.x = Vector2(-3, 0)
		pass

func tick_hanging_out():
	age += 1
	if age > lifetime:
		depart()

func tick_depart():
	print("L E A V I N G")

func _on_VisibilityNotifier2D_viewport_entered(viewport):
	print("Spawned")

func arrive():
	print("Arrived!")
	arriving = false

func depart():
	print("Departing")
	departing = true

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
