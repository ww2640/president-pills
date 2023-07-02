extends Node2D

@onready var pills_pf = preload("res://Scene/Base Pill.tscn")
@onready var unselected_pills_parent = $"../Unselected_Pills"
@export var initial_position = Vector2(640, 360)
@export var instantiate_gap_x = 100

func _ready():
	instantiate_pills("Default", 2, initial_position, [PillBehavior.SIDE_EFFECT.aggressive])

# Called when the node enters the scene tree for the first time.
func instantiate_pills(_name: String, _cure_point: int, _position, side_effect = []):
	var new_pill = pills_pf.instantiate()
	new_pill.name = _name
	new_pill.cure_point = _cure_point
	for effect in side_effect:
		new_pill.side_effects.append(effect)
	new_pill.global_position = _position
	unselected_pills_parent.add_child(new_pill)
