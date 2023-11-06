extends CharacterBody2D

const max_speed = 200
const accel = 600
const friction = 600
var input = Vector2.ZERO


var shoot_velocity = 1000
var speed = 100.0
var fire_rate = 0.1
var can_fire = true
var projectile_scene = preload("res://prefab/shootable.tscn")



func get_input():
	input.x = int(Input.is_action_pressed("d_action")) - int(Input.is_action_pressed("a_action"))
	input.y = int(Input.is_action_pressed("s_action")) - int(Input.is_action_pressed("w_action"))
	
	return input.normalized()
	
func _physics_process(delta):
	player_movemnet(delta)
	look_at(get_global_mouse_position())
	_shooting()
	

func player_movemnet(delta):
	input = get_input()
	
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * accel * delta)
		velocity = velocity.limit_length(max_speed)
	move_and_slide()
	return
	
	
func _shooting():
	if Input.is_action_pressed("fire") and can_fire:
		var bullet_ins = projectile_scene.instantiate()
		bullet_ins.position = $bulletpoint.global_position
		bullet_ins.rotation_degrees = rotation
		bullet_ins.apply_impulse(Vector2(cos(rotation), sin(rotation)) * shoot_velocity, Vector2())
		#bullet_ins.script = script_bullet
		get_tree().get_root().add_child(bullet_ins)
		can_fire = false
		await get_tree().create_timer(fire_rate).timeout
		can_fire = true
	
	return
	
	
