extends Control

@export_file("*.json") var json_file
@export var button_spacing: float = 60.0

@onready var selection_button = load("res://Dialogue/SelectionButton.tscn")

@onready var selection_button_panel = $selection_button_panel
var selection = []
var total_selection_num = 0

signal button_pressed(button_id: int, switch_to_id: int)

func _ready():
	selection = load_selection()
	total_selection_num = len(selection[0])
	set_up_buttons()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_selection():
	var file = FileAccess.open(json_file, FileAccess.READ)
	return JSON.parse_string(file.get_as_text())

func set_up_buttons():
	for i in range(0, total_selection_num):
		var selection_button_instance = selection_button.instantiate()
		selection_button_panel.add_child(selection_button_instance)
		selection_button_instance.position.y += i * 60
		selection_button_instance.set_button_text(selection[0][i]["text"])
		selection_button_instance.set_id(i)
		selection_button_instance.set_switch_to_id(selection[0][i]["switch_to"])
		selection_button_instance.connect("selection_button_pressed", selection_button_pressed)

func selection_button_pressed(button_id, switch_to_id):
	visible = false
	print("Pressed: " + str(button_id))
	print("Switch to:" + str(switch_to_id))
	button_pressed.emit(button_id, switch_to_id)
	
