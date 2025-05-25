extends CharacterBody2D

const SPEED = 200.0 # Set your desired speed

var rng = RandomNumberGenerator.new()

@onready var character_body_2d: CharacterBody2D = $"."
@onready var hand_1: CPUParticles2D = $hand1
@onready var hand_2: CPUParticles2D = $hand2

func _ready():
	# mouse control
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	var mouse_position = Vector2(position.x, position.y)
	get_viewport().warp_mouse(mouse_position)

func _process(delta):
	if Input.is_action_pressed("exit"):
		get_tree().quit()

func _input(event):
	# mouse movement
	if event is InputEventMouseMotion:
		character_body_2d.global_position = get_global_mouse_position()
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			hand_1.emitting = true
			get_viewport().set_input_as_handled()
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
			hand_1.emitting = false
			get_viewport().set_input_as_handled()

		if event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
			hand_2.emitting = true
			get_viewport().set_input_as_handled()
		if event.button_index == MOUSE_BUTTON_RIGHT and event.is_released():
			hand_2.emitting = false
			get_viewport().set_input_as_handled()
