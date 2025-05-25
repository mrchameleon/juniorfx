extends CharacterBody2D

const SPEED = 200.0 # Set your desired speed

var rng = RandomNumberGenerator.new()
var target_pos = Vector2(0,0)


@onready var character_body_2d: CharacterBody2D = $"."
@onready var hand_1: CPUParticles2D = $hand1
@onready var hand_2: CPUParticles2D = $hand2

func _ready():
	while true:
		target_pos = Vector2(
			rng.randf_range(
				0, 
				get_viewport().size.x - 25
			),
			rng.randf_range(
				0, 
				get_viewport().size.y - 25
			)
		)
		await get_tree().create_timer(0.5).timeout

func _process(delta):

	# Move the sprite towards the target position
	var speed = 400  # Adjust for desired speed
	var direction = (target_pos - character_body_2d.position).normalized()
	character_body_2d.position += direction * speed * delta

	# Optional: Handle edge of screen logic
	if character_body_2d.position.x < 0:
		character_body_2d.global_position.x = 0
	if character_body_2d.position.y < 0:
		character_body_2d.global_position.y = 0
	if character_body_2d.position.x > get_viewport().size.x:
		character_body_2d.global_position.x = get_viewport().size.x
	if character_body_2d.position.y > get_viewport().size.y:
		character_body_2d.global_position.y = get_viewport().size.y
	if Input.is_action_pressed("exit"):
		get_tree().quit()


func _input(event):
	# mouse movement
	#if event is InputEventMouseMotion:
		#character_body_2d.global_position = get_global_mouse_position()
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			hand_2.emitting = !hand_1.emitting
			get_viewport().set_input_as_handled()

		if event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
			hand_2.emitting = !hand_2.emitting
			get_viewport().set_input_as_handled()
