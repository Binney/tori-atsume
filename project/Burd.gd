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

# Dropped when tbe bird arrives
export var base_money_min = 1
export var base_money_max = 3

var age = 0
var arriving = true
var departing = false
var destination

var rng = RandomNumberGenerator.new()

const PIXEL_SCALE_FACTOR = 2

func _ready():
	rng.randomize()
	pass

func tweet():
	print("TWIET")
	$AudioStreamPlayer.play()

func set_flightpath(path):
	$BurdPath.set_curve(path)

func set_destination(node):
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
	if age >= lifetime || siesta <= 0:
		if age >= lifetime:
			drop_bonus_money()
		depart()

func tick_depart():
	if $BurdPath/BurdPathFollow.offset - flight_speed < 0:
		queue_free()
		return

	var old_x = $BurdPath/BurdPathFollow.position.x
	$BurdPath/BurdPathFollow.offset -= flight_speed
	var new_x = $BurdPath/BurdPathFollow.position.x

	if (old_x > new_x):
		$BurdPath/BurdPathFollow/AnimatedSprite.transform.x = Vector2(-PIXEL_SCALE_FACTOR, 0)
	else:
		$BurdPath/BurdPathFollow/AnimatedSprite.transform.x = Vector2(PIXEL_SCALE_FACTOR, 0)

func _on_VisibilityNotifier2D_viewport_entered(_viewport):
	print("Spawned")

func arrive():
	print("Arrived!")
	arriving = false
	drop_base_money()
	if destination.has_method('set_being_consumed'):
		destination.set_being_consumed(true)
	if destination.floatable && $BurdPath/BurdPathFollow/AnimatedSprite.frames.has_animation("float"):
		$BurdPath/BurdPathFollow/AnimatedSprite.play("float")
	else:
		$BurdPath/BurdPathFollow/AnimatedSprite.play("perch")

func depart():
	print("Departing")
	if destination.has_method('free_feeder'):
		destination.free_feeder()
	departing = true
	$BurdPath/BurdPathFollow/AnimatedSprite.play("flap")

func drop_base_money():
	# Pick a random integer between base_money_min and base_money_max
	# This will be the number of coins the user
	# receives when a bird arrives
	var base_money = rng.randi_range(base_money_min, base_money_max)
	InventoryManagement._update_Money(base_money)

func drop_bonus_money():
	# Pick a random integer between 1 and 3
	# This will be the number of coins the user
	# gets if a bird has their fill
	var extra_money = rng.randi_range(1, 3)
	InventoryManagement._update_Money(extra_money)

func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	queue_free()
