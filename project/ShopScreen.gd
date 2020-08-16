extends Node2D

# Declare member variables here. Examples:
var current_item = "SeedBucket"

# Called when the node enters the scene tree for the first time.
func _ready():
	ShopScreen.hide()

func _on_Buy_button_up():
	#BUY ITEMS
	#InventoryManagement._add_to_inventory("SeedBucket")
	#InventoryManagement._add_to_inventory("GenericItem")
	print("Buying {str}".format({"str":current_item}))
	InventoryManagement._add_to_inventory(current_item)

func _on_Item1_button_up():
	print("Selecting SeedBucket")
	current_item = "SeedBucket"

func _on_Item2_button_up():
	print("Selecting MeatBucket")
	current_item = "MeatBucket"

func _on_Item3_button_up():
	print("Selecting FruitBucket")
	current_item = "FruitBucket"

func _on_Item4_button_up():
	print("Selecting GooBucket")
	current_item = "GooBucket"
