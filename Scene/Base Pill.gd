extends Node2D

@export var pill_name: String
@export var cure_point: int
@export var side_effects: Array[PillBehavior.SIDE_EFFECT]


func get_side_effects():
	return side_effects
	
func get_cure_point():
	return cure_point

func get_pill_name():
	return pill_name


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("I've been clicked")
		get_node("../../").add_selected_pill(self)
