extends Node2D


# Declare member variables here. Examples:
export var item_name = 'GenericItem'
export(int) var item_cost = 1
export var item_texture = 'res://itemart/loafcat.PNG'
export var count = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	$Texture.texture = load(item_texture)
	$Texture.rect_size.x = 30
	$Texture.rect_size.y = 44
	$ItemCount.text = "1"
	
func _update_count(val):
	count += val 
	$ItemCount.text = str(count)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _try_action_in_garden():
	var managed = false
	managed = Garden.fillBucket("res://itemart/seedbucket.png")
	if not managed:
		managed = Garden.fillTree()
	# !!! should be implemented in subclass
	return managed
		

func _on_Texture_gui_input(event):
	if Garden.in_garden and event is InputEventMouseButton and event.is_pressed():
		var used_item = _try_action_in_garden()
		if used_item:
			InventoryManagement._remove_from_inventory(item_name)		 # Replace with function body.

