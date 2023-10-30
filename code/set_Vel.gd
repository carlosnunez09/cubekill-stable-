extends RigidBody2D

var velocity = Vector2()

func _process(delta):
	# Move the projectile based on its velocity
	move_and_collide(velocity * 3)
