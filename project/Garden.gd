extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (PackedScene) var Burd


# Called when the node enters the scene tree for the first time.
func _ready():    
	randomize()
	new_game()

func new_game():
	$BurdTimer.start()

	
func _on_BurdTimer_timeout():
	$BurdPath/SpawnBurdLocation.offset = randi()
	var burd = Burd.instance()
	add_child(burd)
	# Set the mob's direction perpendicular to the path direction.
	var direction = $BurdPath/SpawnBurdLocation.rotation + PI / 2
	# Set the mob's position to a random location.
	burd.position = $BurdPath/SpawnBurdLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	burd.rotation = direction
	# Set the velocity (speed & direction).
	burd.linear_velocity = Vector2(rand_range(burd.min_speed, burd.max_speed), 0)
	burd.linear_velocity = burd.linear_velocity.rotated(direction)
