extends "Item.gd"

var available = true

func _try_action_in_garden():
	var managed = false
	managed = Garden.fillGardenSpace(item_name.to_lower())
	if managed:
		available = false
	return managed
