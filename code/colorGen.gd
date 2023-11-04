extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var rng = RandomNumberGenerator.new()
	#rng.seed = Time.get_unix_time_from_system()
	var r = rng.randf_range(0.5, 1.0)
	var g = rng.randf_range(0.5, 1.0)
	var b = rng.randf_range(0.5, 1.0)
	
	var sprite = self 
	
	#spite.modulate = Color(r,g,b,1)
	sprite.modulate = Color(r,g,b,1)
	


	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(get_parent().get_node("playerSprite").get_modulate())
	pass


