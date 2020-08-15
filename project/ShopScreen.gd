extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	ShopScreen.hide()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Buy_button_up():
	#BUY ITEMS
	InventoryManagement._add_to_inventory("GenericItem")

