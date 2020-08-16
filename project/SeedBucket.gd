extends "Item.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _init():
	item_name = 'SeedBucket'
	item_cost = 1
	item_texture = 'res://itemart/seedbucket.png'


func _try_action_in_garden():
	var managed = false
	managed = Garden.fillBucket(item_name.to_lower())
	return managed
