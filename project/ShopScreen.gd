extends Node2D

# Declare member variables here. Examples:
var current_item = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	ShopScreen.hide()

func _on_Buy_button_up():
	#BUY ITEMS
	if len(current_item) == 0:
		# Buyer has not chosen an item to buy
		$NullBuyCheck.popup_centered()
	else:
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
	
func _on_Item5_button_up():
	print("Selecting NestBox")
	current_item = "NestBox"

func _on_Item6_pressed():
	print("Selecting WaterBucket")
	current_item = "WaterBucket"

func _on_Item7_pressed():
	print("Selecting IceBucket")
	current_item = "IceBucket"

func _on_Item8_pressed():
	print("Selecting Tree")
	current_item = "FruitTree"
