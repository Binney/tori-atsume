extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var min_speed = 150  # Minimum speed range.
export var max_speed = 250  # Maximum speed range.
export(SpriteFrames) var frames setget set_frames

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func set_frames(new_frames):
	frames = new_frames
	$AnimatedSprite.frames = new_frames
