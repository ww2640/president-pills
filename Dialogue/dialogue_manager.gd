extends Control

@export_file("*.json") var json_file
@export var add_character_time: float

@onready var background = $Background
@onready var name_label = $Background/NameLabel
@onready var text_label = $Background/TextLabel

var dialogue = []
var current_dialogue_id = 0
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
		
func next_script():
	current_dialogue_id += 1
	
	if current_dialogue_id >= len(dialogue[0]):
		d_active = false
		background.visible = false
		return
	
	name_label.text = dialogue[0][current_dialogue_id]['name']
	show_text_one_by_one()

func show_text_one_by_one():
	var current_text_index = 0
	adding_text = true
	text_label.text = ""
	var current_dialogue_block = dialogue[0]
	while len(text_label.text) < len(current_dialogue_block[current_dialogue_id]['text']):
		text_label.text += current_dialogue_block[current_dialogue_id]['text'][current_text_index]
		await get_tree().create_timer(add_character_time).timeout
		current_text_index += 1
	adding_text = false

func show_all_text():
	text_label.text = dialogue[0][current_dialogue_id]['text']
	adding_text = false
