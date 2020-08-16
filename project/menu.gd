extends Control

func _on_GardenButton_pressed():
	Garden._in_garden()
	self.hide()

func _on_HowToPlayButton_pressed():
	get_tree().change_scene("res://HowToPlay.tscn")
