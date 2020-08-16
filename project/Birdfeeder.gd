extends Node2D

# NOTE: Birds will land on the feeder at (0,0), so make sure to
# offset your sprite by the right amount that there's a perch there.

var fullness = 10
var being_consumed = false

# Birds can "lock" a birdfeeder so maximum 1 bird has this feeder as its target at a time
var locked = false

const CONSUMPTION_RATE = 0.5

func _ready():
	pass # Replace with function body.

func fill(amount):
	print("Filled")
	fullness = amount
	pass

func tick():
	if being_consumed:
		fullness -= CONSUMPTION_RATE
		if fullness <= 0:
			print("Empty")
			being_consumed = false

func set_being_consumed(value):
	being_consumed = value
