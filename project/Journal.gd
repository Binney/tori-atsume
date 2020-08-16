extends Control


var achievements = {
	"Robin": false,
	"Pigeon": false,
	"Duck": false,
	"Cassowary": false,
	"Penguin": false
}

func _ready():
	hide()

func discover(bird):
	if achievements.has(bird):
		achievements[bird] = true

func display():
	# look it's 22:24 deal with it
	if !achievements.Robin:
		$ScrollContainer/GridContainer/Robin.hide()
	if !achievements.Pigeon:
		$ScrollContainer/GridContainer/Pigeon.hide()
	if !achievements.Duck:
		$ScrollContainer/GridContainer/Duck.hide()
	if !achievements.Cassowary:
		$ScrollContainer/GridContainer/Cassowary.hide()
	if !achievements.Penguin:
		$ScrollContainer/GridContainer/Penguin.hide()
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
