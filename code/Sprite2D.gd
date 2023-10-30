extends Sprite2D


var projectile_scene = preload("res://prefab/shootable.tscn")
var shoot_velocity = 1000

var speed = 100.0

var object_position = Vector2(0, 0)
var key_directions = {
	KEY_W: Vector2(0, -1),
	KEY_S: Vector2(0, 1),
	KEY_A: Vector2(-1, 0),
	KEY_D: Vector2(1, 0)
}



func _ready():
	object_position = position

func _process(delta):
	var velocity = Vector2(0, 0)

	for key in key_directions.keys():
		if Input.is_key_pressed(key):
			velocity += key_directions[key] * speed

	object_position += velocity * delta

	# Limit movement within the bounds of the Sprite2D
	object_position.x = clamp(object_position.x, -get_viewport_rect().size.x / 2, get_viewport_rect().size.x / 2)
	object_position.y = clamp(object_position.y, -get_viewport_rect().size.y / 2, get_viewport_rect().size.y / 2)

	position = object_position
	
	
	# Calculate the mouse position in every frame
	var mouse_pos_xy = get_global_mouse_position()

	# Calculate the direction vector from the sprite to the mouse
	var target_direction = mouse_pos_xy - position

	# Calculate the rotation angle
	var rotation_angle = atan2(target_direction.y, target_direction.x)

	# Apply the rotation
	rotation = rotation_angle
	
	if Input.is_action_pressed("fire"):
		var bullet_ins = projectile_scene.instantiate()
		bullet_ins.position = $bulletpoint.global_position
		bullet_ins.rotation_degrees = rotation
		bullet_ins.apply_impulse(Vector2(cos(rotation), sin(rotation)) * shoot_velocity, Vector2())
		get_tree().get_root().add_child(bullet_ins)
		print("fire")
