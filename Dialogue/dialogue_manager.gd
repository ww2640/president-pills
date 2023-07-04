extends Control

@export_file("*.json") var json_file
@export var add_character_time: float

@onready var background = $Background
@onready var name_label = $Background/NameLabel
@onready var text_label = $Background/TextLabel

signal On_Interlude(interlude_id: int)

var dialogue = []
var current_block_id = 0
var current_dialogue_id = 0
var current_interlude_id = -1
var d_active = false
var adding_text = false

func _ready():
	background.visible = false
	start() # remove when use in the real scene
	
func start():
	if d_active:
		return
	d_active = true
	background.visible = true
	
	dialogue = load_dialogue()
	current_dialogue_id = -1
	next_script()

func load_dialogue():
	var file = FileAccess.open(json_file, FileAccess.READ)
	return JSON.parse_string(file.get_as_text())

func _input(event):
	if not d_active:
		return
	if event.is_action_pressed("ui_accept") \
	or (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		if not adding_text:
			next_script()
		else:
			show_all_text()
		
func stop_dialogue():
	if(current_block_id) >= len(dialogue):
		return true
	if current_dialogue_id >= len(dialogue[current_block_id]):
		d_active = false
		background.visible = false
		current_interlude_id += 1
		On_Interlude.emit(current_interlude_id)
		return true
	else:
		return false

func continue_dialogue():
	d_active = true
	background.visible = true
	current_block_id += 1
	current_dialogue_id = -1
	next_script()

func next_script():
	current_dialogue_id += 1
	
	if stop_dialogue():
		return
	
	name_label.text = dialogue[current_block_id][current_dialogue_id]['name']
	show_text_one_by_one()

func show_text_one_by_one():
	var current_text_index = 0
	adding_text = true
	text_label.text = ""
	var dialogue_block = dialogue[current_block_id]
	while len(text_label.text) < len(dialogue_block[current_dialogue_id]['text']):
		text_label.text += dialogue_block[current_dialogue_id]['text'][current_text_index]
		await get_tree().create_timer(add_character_time).timeout
		current_text_index += 1
	adding_text = false

func show_all_text():
	text_label.text = dialogue[current_block_id][current_dialogue_id]['text']
	adding_text = false
