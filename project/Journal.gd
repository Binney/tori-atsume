extends Control


var sightings = {
	"Robin": 0,
	"Pigeon": 0,
	"Duck": 0,
	"Cassowary": 0,
	"Penguin": 0,
	"Parrot": 0,
	"Hawk": 0
}

func _ready():
	hide()

func discover(bird):
	if sightings.has(bird):
		sightings[bird] += 1

func display():
	# you tell me a better way to do this
	$ScrollContainer/GridContainer/Robin.visible = sightings.Robin > 0
	$ScrollContainer/GridContainer/Pigeon.visible = sightings.Pigeon > 0
	$ScrollContainer/GridContainer/Duck.visible = sightings.Duck > 0
	$ScrollContainer/GridContainer/Cassowary.visible = sightings.Cassowary > 0
	$ScrollContainer/GridContainer/Penguin.visible = sightings.Penguin > 0
	$ScrollContainer/GridContainer/Parrot.visible = sightings.Parrot > 0
	$ScrollContainer/GridContainer/Hawk.visible = sightings.Hawk > 0

	if count_achievements() == 0:
		$EmptyLabel.show()
	show()

func count_achievements():
	var result = 0
	for key in sightings:
		if sightings[key] > 0:
			result += 1
	return result

func get_total_birds_spotted():
	var result = 0
	for key in sightings:
		result += sightings[key]
	return result

func _on_Button_pressed():
	hide()
	Garden._in_garden()
