extends Control

func _on_StartButton_pressed():
	get_tree().change_scene("res://ShopScreen.tscn")
	
func _on_GardenButton_pressed():
	get_tree().change_scene("res://Garden.tscn")
