extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


onready var money = null
const START_MONEY = 10 


const Item = preload("res://Item.tscn")
const SeedBucket = preload("res://SeedBucket.tscn")
var item_name_to_item = {"GenericItem": Item,
						 "SeedBucket": SeedBucket}

# Called when the node enters the scene tree for the first time.
func _ready():
	money = START_MONEY


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_GardenButton_pressed():
	pass
	#get_node("GardenButton").text = "Back to garden view"

func _on_ShopButton_pressed():
	pass

	
func _update_Money(val):
	# val is positive or negative int to update money with
	if money:
		money += val
		var money_counter =  Inventory.get_node("HBoxContainer/Items/Money/MoneyBox/Labels/Counter")
		money_counter.text = str(money)

	
func _add_to_inventory(item_name):
	var items = Inventory.get_node("HBoxContainer/Items/ItemBox").get_children()
	var found = false
	for i in items:
		if i.item_name == item_name:
			found = true
			i._update_count(1)
			break
	if not found:
		Inventory.get_node("HBoxContainer/Items/ItemBox").add_child(item_name_to_item[item_name].instance())
		
func _remove_from_inventory(item_name):		
	var items = Inventory.get_node("HBoxContainer/Items/ItemBox").get_children()
	for i in items:
		if i.item_name == item_name:
			if i.count > 1:
				i._update_count(-1)
			else:
				Inventory.get_node("HBoxContainer/Items/ItemBox").remove_child(i)
			break
		
func _on_ShopButton_button_up():
	#money += 50 
	ShopScreen.show()
	Garden._left_garden()
	#_add_to_inventory("GenericItem")
	#get_node("GardenButton").text = "Back to garden view"
	#_update_Money(50)

func _on_GardenButton_button_up():
	Garden._in_garden()
	ShopScreen.hide()
	#get_tree().change_scene("res://Garden.tscn")





func _on_Counter_ready():
	pass


func _on_Counter_draw():
	$HBoxContainer/Items/Money/MoneyBox/Labels/Counter.text = str(money)
