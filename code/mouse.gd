extends Sprite2D

var speed = 100.0

func _process(delta):
	var target_position = get_global_mouse_pos()
	var direction = (target_position - position).normalized()
	
	position += direction * speed * delta

	# Optional: Limit movement within the bounds of the Sprite2D
	position.x = clamp(position.x, -get_viewport_rect().size.x / 2, get_viewport_rect().size.x / 2)
	position.y = clamp(position.y, -get_viewport_rect().size.y / 2, get_viewport_rect().size.y / 2)
