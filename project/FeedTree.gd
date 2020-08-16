extends "Birdfeeder.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	fullness = 0
	fillable = ["fruittree"]
	
func tick():
	pass		

func fill(item_name):
	$Sprite.visible = true
	fullness = 1
