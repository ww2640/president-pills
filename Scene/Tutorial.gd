extends Node2D

@onready var pill_spawner = $Pills_Spawner

var tutorial_pill


func _ready():
	get_node("Dialogue").connect("On_Interlude", on_interlude)
	
func on_interlude(interlude_id):
	resolve_interlude(interlude_id)
	
func resolve_interlude(id):
	match id:
		0:
			tutorial_pill = pill_spawner.instantiate_pills("Default", 2, -2, Vector2(640, 360), [PillBehavior.SIDE_EFFECT.aggressive])
			tutorial_pill.can_interact = false
			continue_dialogue()
		1:
			tutorial_pill.can_interact = true
			
func continue_dialogue():
	$Dialogue.continue_dialogue()
