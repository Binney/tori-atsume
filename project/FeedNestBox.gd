extends "Birdfeeder.gd"

var empty = true

# Called when the node enters the scene tree for the first time.
func _ready():
	MAX_CAPACITY = 50
	fullness = MAX_CAPACITY
	fillable = ["nestbox"]
	
func tick():
	if being_consumed:
		fullness -= CONSUMPTION_RATE
		if fullness <= MAX_CAPACITY / 2:
			$Sprite.texture = load("res://itemart/nestbox_half.png") 
		if fullness <= 0:
			print("Empty")
			$Sprite.texture = load("res://itemart/nestbox_empty.png") 
			free_feeder()


func fill(item_name):
	print("Filled")
	contents = item_name
	$Sprite.texture = load("res://itemart/nestbox_full.png")
	fullness = MAX_CAPACITY
