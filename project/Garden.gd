extends Node2D


var in_garden = false
const Birdfeeder = preload("Birdfeeder.gd")
const Burd = preload("Burd.gd")
const Robin = preload("res://Robin.tscn")
const Pigeon = preload("res://Pigeon.tscn")
const Cassowary = preload("res://Cassowary.tscn")

const LEFT_WALKING_SPAWN_POINT = Vector2(-200, 450)
const RIGHT_WALKING_SPAWN_POINT = Vector2(1650, 450)


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

func _on_BurdTimer_timeout():
	for child in get_children():
		if (child is Burd):
			child.tick()
	for child in $BirdfeedersLayer.get_children():
		if (child is Birdfeeder):
			child.tick()
	spawn_birds()

func spawn_flying_bird(species, target_birdfeeder):
	var burd = species.instance()
	burd.position.x = 0
	burd.position.y = 0
	burd.tweet()

	$SpawnBurdPath/SpawnBurdPoint.offset = randi()
	var start = $SpawnBurdPath/SpawnBurdPoint.position
	var end = target_birdfeeder.position
	var curve = Curve2D.new()
	curve.add_point(start)
	curve.add_point(end)
	burd.set_flightpath(curve)

	burd.set_destination(target_birdfeeder)
	target_birdfeeder.locked = true
	add_child(burd)

func spawn_walking_bird(species, target_birdfeeder):
	var burd = species.instance()
	burd.position.x = 0
	burd.position.y = 0
	burd.tweet()

	var start = [LEFT_WALKING_SPAWN_POINT, RIGHT_WALKING_SPAWN_POINT][randi() % 2]
	var end = target_birdfeeder.position
	var curve = Curve2D.new()
	curve.add_point(start)
	curve.add_point(end)
	burd.set_flightpath(curve)

	burd.set_destination(target_birdfeeder)
	target_birdfeeder.locked = true
	add_child(burd)


func fillBucket(food_name):
	var managed_fill = false
	var buckets = Garden.get_node("BirdfeedersLayer").get_children()
	for b in buckets:
		if food_name in b.fillable and b.fullness == 0:
			managed_fill = true
			b.fill(food_name)
			break
	return managed_fill
		#res://.import/emptybucket.png
		
func fillTree():
	var managed_fill = false
	var tree = Garden.get_node("Background/Tree")
	if tree.empty:
		managed_fill = true
		tree._fill()
	return managed_fill
	
	

# ======================
# BIRD SPAWNING HATCHERY
# ======================
#
# Add new bird species here
#
# Add whatever spawn criteria you like, but consider at least
# * Ensuring there is a free birdfeeder of this bird's preferred food type
# * Add some randomness using bird.rarity

func spawn_birds():

	var robin = Robin.instance()
	if (randi() % robin.rarity == 0):
		for child in $BirdfeedersLayer.get_children():
			print(child.contents)
			if child.fullness > 0 && !child.locked && child.contents == 'seedbucket':
				spawn_flying_bird(Robin, child)
				return # Don't spawn multiple birds in one tick

	var pigeon = Pigeon.instance()
#	# TODO add in rules about how more pigeons arrive the more pigeons are already here
	if (randi() % pigeon.rarity == 0):
		for child in $BirdfeedersLayer.get_children():
			if child.fullness > 0 && !child.locked:
				spawn_flying_bird(Pigeon, child)
				return # Don't spawn multiple birds in one tick

	var cassowary = Cassowary.instance()
	if (randi() % cassowary.rarity == 0):
		for child in $BirdfeedersLayer.get_children():
			if child.fullness > 0 && !child.locked && child.contents == 'fruitbucket':
				spawn_walking_bird(Cassowary, child)
				return # Don't spawn multiple birds in one tick

	## TODO more birds here
