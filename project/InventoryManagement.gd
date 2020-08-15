extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var money = null
const START_MONEY = 10 

const generic_item = preload("Item.gd")
const Item = preload("res://Item.tscn")

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
		$HBoxContainer/Items/Money/MoneyBox/Labels/Counter.text = str(money)

func _increment_item(item_name):
	print(Inventory.get_node("HBoxContainer/Items/ItemBox"))
	var items = Inventory.get_node("HBoxContainer/Items/ItemBox").get_children()
	var found = false
	for i in items:
		if i.item_name == item_name:
			found = true
			i._update_count(1)
			break
	if not found:
		Inventory.get_node("HBoxContainer/Items/ItemBox").add_child(Item.instance())
	
func _add_to_inventory(item_name):
	_increment_item(item_name)
		
func _on_ShopButton_button_up():
	#money += 50 
	ShopScreen.show()
	Garden.hide()
	#_add_to_inventory("GenericItem")
	#get_node("GardenButton").text = "Back to garden view"
	#_update_Money(50)

func _on_GardenButton_button_up():
	Garden.show()
	ShopScreen.hide()
	#get_tree().change_scene("res://Garden.tscn")





func _on_Counter_ready():
	pass


func _on_Counter_draw():
	$HBoxContainer/Items/Money/MoneyBox/Labels/Counter.text = str(money)
