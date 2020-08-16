extends Node2D

# Declare member variables here. Examples:
var current_item = ""
var purchases = {}
var limited_purchase = {"FruitTree": 1}
# Called when the node enters the scene tree for the first time.
func _ready():
	ShopScreen.hide()

func _maybe_purchase_limited():
	var do_purchase = false
	if current_item in purchases and current_item in limited_purchase:
		if purchases[current_item] < limited_purchase[current_item]:
			do_purchase = true
		else:
			print("You already have as many {str} as possible!".format({"str":current_item}))
			$ExceedItemLimit/RichTextLabel.set_text("You already have as many {str} as possible!".format({"str":current_item}))
			$ExceedItemLimit.popup_centered()
	else:
		do_purchase = true
	if do_purchase:
		do_purchase()
		
func do_purchase():
	if current_item in purchases:
		purchases[current_item] += 1
	else:
		purchases[current_item] = 1
	print("Buying {str}".format({"str":current_item}))
	InventoryManagement._add_to_inventory(current_item)
	InventoryManagement._update_Money(InventoryManagement.item_name_to_item[current_item].instance().get("item_cost") * -1)
	
func _on_Buy_button_up():
	# Check if current_item is set to ""
	# i.e. user has not selected anything
	# warn them using popup.
	if _check_money():
		# User has enough money
		if len(current_item) == 0:
			# However, user has not selected an item to buy
			$NullBuyCheck.popup_centered()
		else:
			# Has money and selected something - let purchase happen
			_maybe_purchase_limited()
	else:
		if len(current_item) == 0: 
			# No money and no selected item
			$NoFundsCheck.popup_centered()
		else:
			# No money but selected item
			$NoFundsCheck.popup_centered()

func _check_money():
	# Function to check if user has 
	# enough money (internal name: BirbBucks)
	# to complete purchase
	var item_to_buy = InventoryManagement.item_name_to_item[current_item].instance()
	if InventoryManagement.money >= item_to_buy.get("item_cost"):
		# lol infinite money if you forget the multiplication by -1
		return true
	else:
		return false
	
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
