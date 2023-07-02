extends Node2D

var selected_pills = []

func _ready():
	pass
	
func add_selected_pill(new_pill):
	var pill = new_pill.duplicate()
	selected_pills.append(pill)
	print(selected_pills.size())


func _on_button_pressed():
	for pill in selected_pills:
		print(pill.get_side_effects())
		get_node("Label").text = pill.name + "\n"
