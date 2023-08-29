extends Button

signal selection_button_pressed(pressed_button_id: int, pressed_switch_to_id: int)

var button_id = -1
var switch_to_id = -1

func set_button_text(new_text):
	text = new_text

func set_id(new_id):
	button_id = new_id
	
func set_switch_to_id(new_switch_to_id):
	switch_to_id = new_switch_to_id

func _on_pressed():
	emit_signal("selection_button_pressed", button_id, switch_to_id)
