extends RigidBody2D

var lifespan = 4.0  # Adjust this to set the bullet's lifespan in seconds
var time_to_live = lifespan

func _process(delta):
	time_to_live -= delta

	if time_to_live <= 0:
		queue_free()

func _on_BulletTimer_timeout():
	pass  # No need to connect the Timer, so this is an empty function
