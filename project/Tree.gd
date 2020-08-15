extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var texture_name = "res://itemart/loafcat.PNG"
var empty = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _fill():
	empty = false
	self.texture = load(texture_name)

func _empty():
	pass
	#empty = true # gets knocked down by cassowary? replace with fallen tree?
	#self.texture = load("res://itemart/emptybucket.png")

