extends "Item.gd"

func _init():
	item_name = 'FruitBucket'
	item_cost = 1
	item_texture = 'res://itemart/fruitbucket.png'

func _try_action_in_garden():
	var managed = false
	managed = Garden.fillBucket(item_texture)
	return managed
