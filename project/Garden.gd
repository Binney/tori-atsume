extends Node2D



var in_garden = false
const Burd = preload("burd.gd")
const Robin = preload("res://Robin.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():    
	randomize()
	hide()
	new_game()

func _in_garden():
	in_garden = true
	Garden.show()
	
func _left_garden():
	in_garden = false
	Garden.hide() 

func new_game():
	$BurdTimer.start()
	spawnRobin()


func _on_BurdTimer_timeout():
#	spawnRobin()
	for child in get_children():
		if (child is Burd):
			child.tick()

func spawnRobin():
	$BurdPath/SpawnBurdLocation.offset = randi()
	var burd = Robin.instance()
	add_child(burd)
	var direction = $BurdPath/SpawnBurdLocation.rotation + PI / 2
	# Set the mob's position to a random location.
	burd.position = $BurdPath/SpawnBurdLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	burd.rotation = direction
	burd.tweet()
	
func fillBucket(texture):
	var managed_fill = false
	var buckets = Garden.get_node("Background/BirdTable").get_children()
	for b in buckets:
		if b.empty:
			managed_fill = true
			b._fill(texture)
			break
	return managed_fill
		#res://.import/emptybucket.png
		
func fillTree(texture):
	var managed_fill = false
	var tree = Garden.get_node("Background/Tree")
	if tree.empty:
		managed_fill = true
		tree._fill()
	return managed_fill
