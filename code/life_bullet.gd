extends RigidBody2D

var lifespan = 4.0  # Adjust this to set the bullet's lifespan in seconds
var time_to_live = lifespan

func _ready():
	var rng = RandomNumberGenerator.new()
	self.modulate = Color(rng.randf_range(0.4, 1), rng.randf_range(0.4, 1), rng.randf_range(0.4, 1))

	#print(Color(rng.randf_range(0.4, 1), rng.randf_range(0.4, 1), rng.randf_range(0.4, 1))
	return

func _process(delta):
	time_to_live -= delta

	if time_to_live <= 0:
		queue_free()

func _on_BulletTimer_timeout():
	pass  # No need to connect the Timer, so this is an empty function
