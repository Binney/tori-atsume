extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var empty = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _fill(texture_name):
	empty = false
	self.texture = load(texture_name)

func _empty():
	empty = true
	self.texture = load("res://itemart/emptybucket.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
