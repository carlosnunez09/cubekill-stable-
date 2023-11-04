extends RigidBody2D 


var projectile_scene = preload("res://prefab/shootable.tscn")


var shoot_velocity = 1000
var speed = 100.0
var max_speed = 200.0
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
	#object_position = Vector2(0,0)
	


func _physics_process(delta):

	look_at(get_global_mouse_position())
	pass


func _process(delta):
	if Input.is_action_pressed("fire") and can_fire:
		var bullet_ins = projectile_scene.instantiate()
		bullet_ins.position = $bulletpoint.global_position
		bullet_ins.rotation_degrees = rotation
		bullet_ins.apply_impulse(Vector2(cos(rotation), sin(rotation)) * shoot_velocity, Vector2())
		#bullet_ins.script = script_bullet
		get_tree().get_root().add_child(bullet_ins)
		print(bullet_ins.script)
		can_fire = false
		await get_tree().create_timer(fire_rate).timeout
		can_fire = true
		
		
