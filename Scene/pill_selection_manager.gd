extends Node2D

@onready var pills_pf = preload("res://Scene/Base Pill.tscn")
@onready var unselected_pills_parent = $Unselected_Pills
var selected_pills = []

@export var initial_position = Vector2(640, 360)
@export var instantiate_gap_x = 100

func _ready():
	instantiate_pills(3)
	
func add_selected_pill(new_pill):
	selected_pills.append(new_pill)
	print(selected_pills.size())


func _on_button_pressed():
	for pill in selected_pills:
		print(pill.get_side_effects())

func instantiate_pills(num: int):
	for i in range(num):
		var new_pill = pills_pf.instantiate()
		new_pill.name = "new name"
		new_pill.cure_point = 2
		new_pill.side_effects.append(PillBehavior.SIDE_EFFECT.sleepy)
		new_pill.global_position = initial_position + Vector2(i * instantiate_gap_x, 0)
		unselected_pills_parent.add_child(new_pill)
