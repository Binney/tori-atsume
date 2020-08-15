extends Node2D


# Declare member variables here. Examples:
export var item_name = 'GenericItem'
export(int) var item_cost = 1
export var item_texture = ''

# Called when the node enters the scene tree for the first time.
func _ready():
	get.node("ItemSprite").texture = load(item_texture)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
