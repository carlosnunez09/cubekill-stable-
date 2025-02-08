extends CharacterBody2D


const max_speed = 200
const accel = 600
const friction = 600
var input = Vector2.ZERO
var currentScale = 20


var shoot_velocity = 900
var speed = 100.0
var fire_rate = 0.1
var can_fire = true
var projectile_scene = preload("res://prefab/shootable.tscn")

var regenRate = 0.9
var regen = false
var staminaTimer = 0.0
var staminaMax = 20
var staminaCost = 0.1
var staminaCollDownMax = 10





func _process(delta):
	#i want to make the stamina bar regen over time if has not been used for a x amount of time use regen as a false true, remove time from stamina timer and samina max is ow long the timer si

	#check if is owner with if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():

	
	if not regen:
		staminaTimer -= delta
		if staminaTimer <= 0:
			regen = true
	else:
		if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
			var stamina_bar = self.get_parent().get_node("CanvasLayer/stamina/moveable")
			#incresse stamina until it reaches max
			if stamina_bar.scale.x < staminaMax:
				stamina_bar.scale.x = min(stamina_bar.scale.x + delta * regenRate, staminaMax)
	#if regenTimer at a certim point tunr regen to true


		

func _ready():
	print("Printing the scene tree:")
	print_tree()
	$MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())
	pass


func get_input():
	input.x = int(Input.is_action_pressed("d_action")) - int(Input.is_action_pressed("a_action"))
	input.y = int(Input.is_action_pressed("s_action")) - int(Input.is_action_pressed("w_action"))
	
	return input.normalized()
	
func _physics_process(delta):
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		player_movemnet(delta)
		look_at(get_global_mouse_position())
		if Input.is_action_pressed("fire") and can_fire:
			_shooting.rpc()
		var collision = move_and_collide(velocity* delta)
		if collision:
			var collided_object = collision.get_collider()
			if collided_object and collided_object.has_method("getId"):  # Ensure it has getId()
				print("Collided with:", collided_object.getId())
				if(collided_object.getId() == multiplayer.get_unique_id()):
					print("you hit got hit by ", collided_object.getId())
					#make sure to add to the gamemanager points to opposite side
					return
				
				
	

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
	
@rpc("any_peer","call_local")
func _shooting():
	var stamina_bar = self.get_parent().get_node("CanvasLayer/stamina/moveable") #move up
	
	if stamina_bar.scale.x >= staminaCost and $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		stamina_bar.scale.x -= staminaCost
		staminaTimer = staminaCollDownMax
		regen = false
		#reset timer
	if stamina_bar.scale.x < staminaCost:
		return
	var bullet_ins = projectile_scene.instantiate()
	bullet_ins.position = $bulletpoint.global_position
	bullet_ins.rotation_degrees = rotation
	bullet_ins.id_Player = multiplayer.get_unique_id() 
	bullet_ins.apply_impulse(Vector2(cos(rotation), sin(rotation)) * shoot_velocity, Vector2())
		#bullet_ins.script = script_bullet
	get_tree().get_root().add_child(bullet_ins)
	#can_fire = false
	#await get_tree().create_timer(fire_rate).timeout
	#can_fire = true
	return
	
	
	
	
