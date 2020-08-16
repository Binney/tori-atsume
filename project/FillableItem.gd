extends "Item.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

func _try_action_in_garden():
	var managed = false
	managed = Garden.fillBucket(item_name.to_lower())
	return managed
