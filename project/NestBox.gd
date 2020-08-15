extends TextureRect

var empty = true

# Called when the node enters the scene tree for the first time.
func _ready():
	self.texture = load("res://itemart/nestbox_empty.png")
	self.rect_scale.x = 1.5
	self.rect_scale.y = 1.5
	
func _fill():
	empty = false
	self.texture = load("res://itemart/nestbox_full.png")

func _empty():
	empty = true
	self.texture = load("res://itemart/nestbox_empty.png")


