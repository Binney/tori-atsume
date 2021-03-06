extends Node2D

# NOTE: Birds will land on the feeder at (0,0), so make sure to
# offset your sprite by the right amount that there's a perch there.

var MAX_CAPACITY = 100
var fullness = 0
var being_consumed = false
var contents = null
var floatable = false

var fillable = []
# Birds can "lock" a birdfeeder so maximum 1 bird has this feeder as its target at a time
var locked = false

const CONSUMPTION_RATE = 1

func _ready():
	pass
	
func fill(item_name):
	print("Filled")
	contents = item_name
	$Sprite.texture = load("res://itemart/{str}.png".format({"str":item_name}))
	fullness = MAX_CAPACITY

func empty_texture():
	pass # should be implemented in subclass

func free_feeder():
	if being_consumed:
		set_being_consumed(false)
	if locked: 
		locked = false


func tick():
	if being_consumed:
		fullness -= CONSUMPTION_RATE
		if fullness <= 0:
			print("Empty")
			empty_texture()
			free_feeder()
			
func set_being_consumed(value):
	being_consumed = value
