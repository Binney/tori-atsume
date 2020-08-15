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
	spawn_robin()

func _on_BurdTimer_timeout():
	if (rand_range(0,1) > 0.95):
		spawn_robin()
	for child in get_children():
		if (child is Burd):
			child.tick()

func spawn_robin():
	var burd = Robin.instance()
	add_child(burd)

	burd.position.x = 500
	burd.position.y = -20
	burd.tweet()
	$SpawnBurdPath/SpawnBurdPoint.offset = randi()
	$BurdLandPath/BurdLandPoint.offset = randi()
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
