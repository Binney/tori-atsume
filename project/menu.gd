extends Control

func _on_StartButton_pressed():
	ShopScreen.show()
	self.hide()


func _on_GardenButton_pressed():
	Garden.show()
	self.hide()
	#get_tree().change_scene("res://Garden.tscn")
