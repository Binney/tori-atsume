extends Node2D


# Declare member variables here. Examples:
var current_item


# Called when the node enters the scene tree for the first time.
func _ready():
	ShopScreen.hide()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Buy_button_up():
	#BUY ITEMS
	#InventoryManagement._add_to_inventory("SeedBucket")
	#InventoryManagement._add_to_inventory("GenericItem")
	InventoryManagement._add_to_inventory(current_item)

func _on_Item1_button_up():
	print("Adding SeedBucket")
	current_item = "SeedBucket"


func _on_Item2_button_up():
	print("Adding MeatBucket")
	current_item = "MeatBucket"
