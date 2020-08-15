extends Node2D




const Burd = preload("burd.gd")
const Robin = preload("res://Robin.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():    
	randomize()
	new_game()

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
	
