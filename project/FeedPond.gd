extends "Birdfeeder.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	fullness = 0
	$Sprite.visible = false
	fillable = ["pond"]
	floatable = true
func tick():
	pass		

func fill(item_name):
	$Sprite.visible = true
	fullness = 1
	contents = item_name
