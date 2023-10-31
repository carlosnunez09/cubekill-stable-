extends RigidBody2D 


var projectile_scene = preload("res://prefab/shootable.tscn")
var shoot_velocity = 1000
var speed = 100.0
var fire_rate = 0.1

var can_fire = true


var object_position = Vector2(0, 0)
var key_directions = {
	KEY_W: Vector2(0, -1),
	KEY_S: Vector2(0, 1),
	KEY_A: Vector2(-1, 0),
	KEY_D: Vector2(1, 0)
}



func _ready():
	object_position = position

	# Create and set up the timer


func _physics_process(delta):
	var velocity = Vector2(0, 0)

	for key in key_directions.keys():
		if Input.is_key_pressed(key):
			velocity += key_directions[key] * speed

	object_position += velocity * delta

	# Limit movement within the bounds of the Sprite2D
	object_position.x = clamp(object_position.x, -get_viewport_rect().size.x / 2, get_viewport_rect().size.x / 2)
	object_position.y = clamp(object_position.y, -get_viewport_rect().size.y / 2, get_viewport_rect().size.y / 2)

	position = object_position
	
	look_at(get_global_mouse_position())
	
	#var mouse_pos_xy = get_global_mouse_position()
	#var target_direction = mouse_pos_xy - position
	#var rotation_angle = atan2(target_direction.y, target_direction.x)
	#rotation = rotation_angle
	
	
	
	
	
	
	pass


func _process(delta):
	
	
	
	
	if Input.is_action_pressed("fire") and can_fire:
		var bullet_ins = projectile_scene.instantiate()
		bullet_ins.position = $bulletpoint.global_position
		bullet_ins.rotation_degrees = rotation
		bullet_ins.apply_impulse(Vector2(cos(rotation), sin(rotation)) * shoot_velocity, Vector2())
		get_tree().get_root().add_child(bullet_ins)
		can_fire = false
		await get_tree().create_timer(fire_rate).timeout
		can_fire = true
		print("fire")

