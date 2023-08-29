extends Control

signal selection_button_pressed(pressed_button_id: int)

var button_id = -1

func set_text(new_text):
	self.text = new_text

func set_id(new_id):
	button_id = new_id

func _on_pressed():
	emit_signal("selection_button_pressed", button_id)
