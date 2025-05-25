extends CPUParticles2D

func _input(InputEvent):
	if Input.is_action_pressed("fire"):
		emitting = true
	else:
		emitting = false
