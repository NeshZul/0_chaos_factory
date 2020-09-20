extends Area2D
var bullet = preload("res://bullet_laser.tscn")
var dir 
var hp
var turn_speed = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_rotate()

func _rotate():
	dir = get_angle_to(get_global_mouse_position())
	if abs(dir) < turn_speed:
		rotation += dir 
	else:
		if dir > 0: rotation += turn_speed #clockwise
		if dir < 0: rotation -= turn_speed #anit - clockwise


func _get_dir(direction):
	direction = self.rotation
	
