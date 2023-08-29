extends Node2D

@onready var pill_spawner = $Pills_Spawner
@onready var selection = $Selection
@onready var dialogue = $Dialogue

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
	dialogue.continue_dialogue()

func selection_button_pressed(button_id, switch_to_id):
	dialogue.jump_to_block(switch_to_id)
