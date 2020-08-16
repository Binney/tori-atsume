extends Control


# Declare member variables here. Examples:
var item_name = null
var item_cost = null
var item_texture = null
var item_formatted_name = null
var count = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	_init()
	$Texture.texture = load(item_texture)
	$Texture.rect_size.x = InventoryManagement.ITEM_WIDTH
	$Texture.rect_size.y = InventoryManagement.ITEM_HEIGHT
	$ItemCount.text = "1"
	
func _init():
	item_name = 'GenericItem'
	item_cost = 1
	item_texture = 'res://itemart/loafcat.PNG'
	
func _update_count(val):
	count += val 
	$ItemCount.text = str(count)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _try_action_in_garden():
	var managed = false
	managed = Garden.fillGardenSpace(item_name.to_lower())
	return managed



func _on_Texture_gui_input(event):
	if Garden.in_garden and event is InputEventMouseButton and event.is_pressed():
		var used_item = _try_action_in_garden()
		if used_item:
			InventoryManagement._remove_from_inventory(item_name)		 # Replace with function body.

