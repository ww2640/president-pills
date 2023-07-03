extends Node2D

@export var pill_name: String
@export var health_point: int
@export var mental_point: int
@export var side_effects: Array[PillBehavior.SIDE_EFFECT]


#func get_side_effects():
#	return side_effects
#
#func get_cure_point():
#	return health_point
#
#func get_pill_name():
#	return pill_name


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("I've been clicked")
		pill_select_anim()
		get_node("../../").add_selected_pill(self)

func pill_select_anim():
	var tween = get_tree().create_tween()
	rotation_degrees = -100
	tween.set_loops(4)
	tween.tween_property($AnimatedSprite2D, "rotation_degrees", 15, 0.3)
	tween.chain().tween_property($AnimatedSprite2D, "rotation_degrees", -15, 0.1)
	tween.connect("finished", queue_free)
