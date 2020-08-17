extends Control


var achievements = {
	"Robin": false,
	"Pigeon": false,
	"Duck": false,
	"Cassowary": false,
	"Penguin": false,
	"Parrot": false,
	"Hawk": false
}

func _ready():
	hide()

func discover(bird):
	if achievements.has(bird):
		achievements[bird] = true

func display():
	# you tell me a better way to do this
	$ScrollContainer/GridContainer/Robin.visible = achievements.Robin
	$ScrollContainer/GridContainer/Pigeon.visible = achievements.Pigeon
	$ScrollContainer/GridContainer/Duck.visible = achievements.Duck
	$ScrollContainer/GridContainer/Cassowary.visible = achievements.Cassowary
	$ScrollContainer/GridContainer/Penguin.visible = achievements.Penguin
	$ScrollContainer/GridContainer/Parrot.visible = achievements.Parrot
	$ScrollContainer/GridContainer/Hawk.visible = achievements.Hawk

	if count_achievements() == 0:
		$EmptyLabel.show()
	show()

func count_achievements():
	var result = 0
	for key in achievements:
		if achievements[key]:
			result += 1
	return result

func _on_Button_pressed():
	hide()
	Garden._in_garden()
