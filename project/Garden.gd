extends Node2D

var in_garden = false
const Birdfeeder = preload("Birdfeeder.gd")
const Burd = preload("Burd.gd")
const Robin = preload("res://Robin.tscn")
const Pigeon = preload("res://Pigeon.tscn")
const Duck = preload("res://Duck.tscn")
const Cassowary = preload("res://Cassowary.tscn")
const Penguin = preload("res://Penguin.tscn")
const Skink = preload("res://Skink.tscn")
const Hawk = preload("res://Hawk.tscn")

const LEFT_WALKING_SPAWN_POINT = Vector2(-200, 450)
const RIGHT_WALKING_SPAWN_POINT = Vector2(1650, 450)


# Called when the node enters the scene tree for the first time.
func _ready():    
	randomize()
	hide()
	new_game()

func _in_garden():
	in_garden = true
	$BurdTimer.start()
	fade_out_music()
	Garden.show()

func fade_out_music():
	$AudioStreamPlayer/Tween.interpolate_property($AudioStreamPlayer, "volume_db", 0, -80, 3, 1, Tween.EASE_IN, 0)
	$AudioStreamPlayer/Tween.start()

func _on_Tween_tween_completed(_object, _key):
	# Finished fading out the audio
	$AudioStreamPlayer.stop()

func _left_garden():
	in_garden = false
	$BurdTimer.stop()
	Garden.hide() 

func new_game():
	pass

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
	var end
	if start.x > target_birdfeeder.position.x:
		end = target_birdfeeder.position + target_birdfeeder.get_child(4).position
	else:
		end = target_birdfeeder.position + target_birdfeeder.get_child(2).position
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
	var end
	if start.x > target_birdfeeder.position.x:
		end = target_birdfeeder.position + target_birdfeeder.get_child(3).position
	else:
		end = target_birdfeeder.position + target_birdfeeder.get_child(1).position
	var curve = Curve2D.new()
	curve.add_point(start)
	curve.add_point(end)
	burd.set_flightpath(curve)

	burd.set_destination(target_birdfeeder)
	target_birdfeeder.locked = true
	add_child(burd)


func fillGardenSpace(food_name):
	var managed_fill = false
	var buckets = Garden.get_node("BirdfeedersLayer").get_children()
	for b in buckets:
		if b.locked == false and food_name in b.fillable and b.fullness == 0:
			managed_fill = true
			b.fill(food_name)
			break
	return managed_fill
		#res://.import/emptybucket.png

	
	

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
			if child.fullness > 0 && !child.locked && child.contents in ['seedbucket', 'waterbucket', 'nestbox']:
				Journal.discover("Robin")
				spawn_flying_bird(Robin, child)
				return # Don't spawn multiple birds in one tick

	var hawk = Hawk.instance()
	if (randi() % hawk.rarity == 0):
		for child in $BirdfeedersLayer.get_children():
			if child.fullness > 0 && !child.locked && child.contents in ['meatbucket']:
				Journal.discover("Hawk")
				spawn_flying_bird(Hawk, child)
				return # Don't spawn multiple birds in one tick

	var duck = Duck.instance()
	if (randi() % duck.rarity == 0):
		for child in $BirdfeedersLayer.get_children():
			if child.fullness > 0 && !child.locked &&  child.contents in ["pond", "waterbucket", "seedbucket", 'nestbox']:
				Journal.discover("Duck")
				spawn_flying_bird(Duck, child)
				return # Don't spawn multiple birds in one tick

	var cassowary = Cassowary.instance()
	if (randi() % cassowary.rarity == 0):
		for child in $BirdfeedersLayer.get_children():
			if child.fullness > 0 && !child.locked && child.contents in ['fruitbucket', 'fruittree']:
				Journal.discover("Cassowary")
				spawn_walking_bird(Cassowary, child)
				return # Don't spawn multiple birds in one tick

	var skink = Skink.instance()
	if (randi() % skink.rarity == 0):
		for child in $BirdfeedersLayer.get_children():
			if child.fullness > 0 && !child.locked && child.contents in ['fruitbucket', 'meatbucket']:
				Journal.discover("Parrot")
				spawn_walking_bird(Skink, child)
				return # Don't spawn multiple birds in one tick

	var penguin = Penguin.instance()
	if (randi() % penguin.rarity == 0):
		for child in $BirdfeedersLayer.get_children():
			if child.fullness > 0 && !child.locked && child.contents in ['icebucket', 'meatbucket']:
				Journal.discover("Penguin")
				spawn_walking_bird(Penguin, child)
				return # Don't spawn multiple birds in one tick

	# Chuck Pigeon at the bottom, because Pigeon is an unfussy eater and will nick other birbs' food given the chance
	var pigeon = Pigeon.instance()
#	# TODO add in rules about how more pigeons arrive the more pigeons are already here
	if (randi() % pigeon.rarity == 0):
		for child in $BirdfeedersLayer.get_children():
			if child.fullness > 0 && !child.locked:
				Journal.discover("Pigeon")
				spawn_flying_bird(Pigeon, child)
				return # Don't spawn multiple birds in one tick


	## TODO more birds here
