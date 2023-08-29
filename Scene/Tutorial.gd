extends Node2D

@onready var pill_spawner = $Pills_Spawner
@onready var selection = $Selection

var tutorial_pill
var interlude_id

func _ready():
	get_node("Dialogue").connect("On_Interlude", on_interlude)
	selection.connect("button_pressed", selection_button_pressed)
	selection.visible = false
	
func on_interlude(id):
	resolve_interlude(id)
	interlude_id = id
	
func resolve_interlude(id):
	match id:
		0:
			tutorial_pill = pill_spawner.instantiate_pills("Default", 2, -2, Vector2(640, 360), [PillBehavior.SIDE_EFFECT.aggressive])
			tutorial_pill.can_interact = false
			continue_dialogue()
		1:
			tutorial_pill.can_interact = true
		2:
			selection.visible = true
func continue_dialogue():
	$Dialogue.continue_dialogue()

func selection_button_pressed(button_id):
	match interlude_id:
		2:
			match button_id:
				0:
					print("xing")
				1:
					print("buxing")
				2:
					print("bushi buxing")
