extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


onready var money = null
const START_MONEY = 10 
const ITEM_WIDTH = 30
const ITEM_HEIGHT = 44

const Item = preload("res://Item.tscn")
const SeedBucket = preload("res://SeedBucket.tscn")
const GooBucket = preload("res://GooBucket.tscn")
const FruitBucket = preload("res://FruitBucket.tscn")
const MeatBucket = preload("res://MeatBucket.tscn")
const NestBox = preload("res://NestBox.tscn")
const WaterBucket = preload("res://WaterBucket.tscn")
const IceBucket = preload("res://IceBucket.tscn")
const FruitTree = preload("res://FruitTree.tscn")
const Pond = preload("res://Pond.tscn")

onready var item_name_to_item = {"GenericItem": Item,
						 "SeedBucket": SeedBucket,
						"FruitBucket": FruitBucket,
						"MeatBucket": MeatBucket,
						"GooBucket": GooBucket,
						"NestBox": NestBox,
						"WaterBucket": WaterBucket,
						"IceBucket": IceBucket,
						"FruitTree": FruitTree,
						"Pond": Pond}

# Called when the node enters the scene tree for the first time.
func _ready():
	money = START_MONEY

	
func _update_Money(val):
	# val is positive or negative int to update money with
	if money != null:
		money += val
		var money_counter =  Inventory.get_node("HBoxContainer/Items/Money/MoneyBox/Labels/Counter")
		money_counter.text = str(money)

func _add_to_inventory(item_name):
	var items = Inventory.get_node("HBoxContainer/Items/ItemBox").get_children()
	var found = false
	for i in items:
		if i.item_name.to_lower() == item_name.to_lower():
			found = true
			i._update_count(1)
			break
	if not found:
		var new_item = item_name_to_item[item_name].instance()
		#new_item = len(items)  
		Inventory.get_node("HBoxContainer/Items/ItemBox").add_child(new_item)
		
func _remove_from_inventory(item_name):		
	var items = Inventory.get_node("HBoxContainer/Items/ItemBox").get_children()
	for i in items:
		if i.item_name.to_lower() == item_name.to_lower():
			if i.count > 1:
				i._update_count(-1)
			else:
				Inventory.get_node("HBoxContainer/Items/ItemBox").remove_child(i)
			break

func _on_ShopButton_pressed():
	if Garden.in_garden:
		Journal.hide()
		ShopScreen.show()
		Garden._left_garden()
		$HBoxContainer/Buttons/ShopButton.text = "Back"
	else:
		Journal.hide()
		Garden._in_garden()
		ShopScreen.hide()
		$HBoxContainer/Buttons/ShopButton.text = "Shop"

func _on_Counter_ready():
	pass

func _on_Counter_draw():
	$HBoxContainer/Items/Money/MoneyBox/Labels/Counter.text = str(money)

func _on_JournalButton_pressed():
	Garden._left_garden()
	Journal.display()
	ShopScreen.hide()
