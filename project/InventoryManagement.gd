extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_GardenButton_pressed():
	pass
	#get_node("GardenButton").text = "Back to garden view"

func _on_ShopButton_pressed():
	pass

	


func _on_ShopButton_button_up():
	get_tree().change_scene("res://ShopScreen.tscn")
	#get_node("GardenButton").text = "Back to garden view"


func _on_GardenButton_button_up():
	get_tree().change_scene("res://Garden.tscn")
