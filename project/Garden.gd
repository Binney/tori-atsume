extends Node2D


const Burd = preload("Burd.gd")
const Robin = preload("res://Robin.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():    
	randomize()
	hide()
	new_game()

func new_game():
	$BurdTimer.start()
	spawnRobin()


func _on_BurdTimer_timeout():
#	spawnRobin()
	for child in get_children():
		if (child is Burd):
			child.tick()
#			print("Moving...")
#			$BurdPath/BurdPoint.offset += 5
#			child.position.x += 5
#			child.position = $BurdPath/BurdPoint.position
#			print($BurdPath/BurdPoint.position)


func spawnRobin():
#	$BurdPath/SpawnBurdLocation.offset = randi()
	var burd = Robin.instance()
	add_child(burd)
#	var direction = $BurdPath/SpawnBurdLocation.rotation + PI / 2
	# Set the mob's position to a random location.
#	burd.position = $BurdPath/SpawnBurdLocation.position
	# Add some randomness to the direction.
#	direction += rand_range(-PI / 4, PI / 4)
#	burd.rotation = direction
	burd.position.x = 500
	burd.position.y = 100
	burd.tweet()
	burd.arrive()
	$SpawnBurdPath/SpawnBurdPoint.offset = 0#randi()
	$BurdLandPath/BurdLandPoint.offset = 0#randi()
	var start = $SpawnBurdPath/SpawnBurdPoint.position
	var end = $BurdLandPath/BurdLandPoint.position
	var curve = Curve2D.new()
	curve.add_point(start)
	curve.add_point(end)
	burd.set_flightpath(curve)
	print("Set curve")
	print(start)
	print(" to ")
	print(end)
