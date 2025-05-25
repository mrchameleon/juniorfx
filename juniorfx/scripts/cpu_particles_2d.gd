extends CPUParticles2D

@onready var character_body_2d: CharacterBody2D = $".."

var mouse_position = null;

func _input(event):
	# mouse controls this one
	if event is InputEventMouseMotion:
		mouse_position = get_global_mouse_position()
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			character_body_2d.global_position = mouse_position;
			emitting = true
			get_viewport().set_input_as_handled()
		#if event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
			#get_viewport().set_input_as_handled()
