extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var money = null
const START_MONEY = 10 
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
		$HBoxContainer/Items/Money/HBoxContainer/Labels/Counter.text = str(money)
	

func _on_ShopButton_button_up():
	#money += 50 
	get_tree().change_scene("res://ShopScreen.tscn")
	#get_node("GardenButton").text = "Back to garden view"
	#_update_Money(50)

func _on_GardenButton_button_up():
	get_tree().change_scene("res://Garden.tscn")





func _on_Counter_ready():
	pass


func _on_Counter_draw():
	$HBoxContainer/Items/Money/HBoxContainer/Labels/Counter.text = str(money)
