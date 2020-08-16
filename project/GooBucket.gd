extends "Item.gd"

func _init():
	item_name = 'GooBucket'
	item_cost = 1
	item_texture = 'res://itemart/goobucket.png'

func _try_action_in_garden():
	var managed = false
	managed = Garden.fillBucket(item_texture)
	return managed
