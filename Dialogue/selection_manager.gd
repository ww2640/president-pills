extends Control

@export_file("*.json") var json_file
@export var button_spacing: float = 60.0

@onready var selection_button = load("res://Dialogue/SelectionButton.tscn")

@onready var selection_button_panel = $selection_button_panel
var selection = []
var total_selection_num = 0

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
		selection_button_instance.set_text(selection[0][i]["text"])
		selection_button_instance.set_id(i)
		selection_button_instance.connect("selection_button_pressed", selection_button_pressed)

func selection_button_pressed(button_id):
	print("Pressed: " + str(button_id))
