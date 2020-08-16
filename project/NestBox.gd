extends "Item.gd"


func _init():
	item_name = 'NestBox'
	item_cost = 1
	item_texture = 'res://itemart/nestbox_full.png'


func _try_action_in_garden():
	var managed = false
	managed = Garden.fillBucket(item_name.to_lower())
	return managed
