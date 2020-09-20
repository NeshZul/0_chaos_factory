extends Particles2D

func _process(delta):
	if not is_emitting():
		
		queue_free()
