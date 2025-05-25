extends Node2D

const FIREWORK = preload("res://scenes/firework.tscn")

func _ready():
	while true:
		var viewport = get_viewport_rect()
		var random_x = randf_range(0, viewport.size.x)
		var random_y = randf_range(0, viewport.size.y)
		var fw = FIREWORK.instantiate()
		fw.global_position = Vector2(random_x, random_y)
		get_parent().add_child(fw)
		
		var random_wait = randf_range(0.2, 0.3)
		await get_tree().create_timer(random_wait).timeout # wait a little bit to do it again

# comment the above ready function and uncomment the below to use mouse control only.
# or leave them both on for an automatic show with ability to add to it with mouse clicks! 

func _input(event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var fw = FIREWORK.instantiate()
		fw.global_position = get_global_mouse_position()
		get_parent().add_child(fw)
