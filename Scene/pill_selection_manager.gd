extends Node2D

var selected_pills = []

func _ready():
	pass
	
func add_selected_pill(new_pill):
	var pill = new_pill.duplicate()
	selected_pills.append(pill)
	resolve_pill_effects(pill)
	print(selected_pills.size())


func _on_button_pressed():
	get_node("Label").text = str(GameManager.p_health)
		
func resolve_pill_effects(pill):
	GameManager.p_health += pill.health_point
	GameManager.p_mental += pill.mental_point
	for effect in pill.side_effects:
		GameManager.p_debuffs.append(effect)
