extends Area2D

# How long will this bird stay here, as long as the birdfeeder has food?
export var lifetime = 60

# How long will this bird stay on the birdfeeder after it runs out of food?
export var siesta = 10

# How common is this bird?
# 1 = it will always appear the moment it has food
# 120 = it will on average appear once a minute if it has food (2 ticks per second)
export var rarity = 1

export var flight_speed = 15

var age = 0
var arriving = true
var departing = false
var destination

const PIXEL_SCALE_FACTOR = 2

func _ready():
	pass

func tweet():
	# TODO actually make a noise
	print("TWIET")

func set_flightpath(path):
	$BurdPath.set_curve(path)
	print($BurdPath/BurdPathFollow.position)

func set_destination(node):
	print("Set destination to")
	print(node)
	destination = node

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
		$BurdPath/BurdPathFollow/AnimatedSprite.transform.x = Vector2(-PIXEL_SCALE_FACTOR, 0)
	else:
		$BurdPath/BurdPathFollow/AnimatedSprite.transform.x = Vector2(PIXEL_SCALE_FACTOR, 0)

func tick_hanging_out():
	age += 1
	if destination.fullness <= 0:
		# No food left, hang around for a bit then leave
		siesta -= 1
	if age > lifetime || siesta <= 0:
		depart()

func tick_depart():
	if $BurdPath/BurdPathFollow.offset - flight_speed < 0:
		print("got to end")
		queue_free()
		return

	var old_x = $BurdPath/BurdPathFollow.position.x
	$BurdPath/BurdPathFollow.offset -= flight_speed
	var new_x = $BurdPath/BurdPathFollow.position.x

	if (old_x > new_x):
		$BurdPath/BurdPathFollow/AnimatedSprite.transform.x = Vector2(-PIXEL_SCALE_FACTOR, 0)
	else:
		$BurdPath/BurdPathFollow/AnimatedSprite.transform.x = Vector2(PIXEL_SCALE_FACTOR, 0)

func _on_VisibilityNotifier2D_viewport_entered(viewport):
	print("Spawned")

func arrive():
	print("Arrived!")
	arriving = false
	if destination.has_method('set_being_consumed'):
		destination.set_being_consumed(true)
	$BurdPath/BurdPathFollow/AnimatedSprite.play("perch")

func depart():
	print("Departing")
	if destination.has_method('free_feeder'):
		destination.free_feeder()
	departing = true
	$BurdPath/BurdPathFollow/AnimatedSprite.play("flap")

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
