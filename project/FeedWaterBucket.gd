extends "Birdfeeder.gd"

var empty = true
const item_to_textures = {"waterbucket": ["res://itemart/waterbucket_full1.png", "res://itemart/waterbucket_half1.png"],
						"icebucket": ["res://itemart/icebucket_full.png", "res://itemart/icebucket_half.png"]}

# Called when the node enters the scene tree for the first time.
func _ready():
	MAX_CAPACITY = 50
	fullness = 0
	fillable = ["waterbucket", "icebucket"]
	
func tick():
	if being_consumed:
		fullness -= CONSUMPTION_RATE
		if fullness <= MAX_CAPACITY / 2:
			$Sprite.texture = load(item_to_textures[contents][1])
		if fullness <= 0:
			print("Empty")
			floatable = false
			$Sprite.texture = load("res://itemart/emptyfloorbucket.png") 
			free_feeder()


func fill(item_name):
	print("Filled")
	contents = item_name
	if contents == "waterbucket":
		floatable = true
	else:
		floatable = false
	$Sprite.texture = load(item_to_textures[contents][0])
	fullness = MAX_CAPACITY
