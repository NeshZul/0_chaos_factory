extends RigidBody2D

export (int) var engine_thrust = 500
export (int) var spin_thrust = 700

var thrust = Vector2()
var rotation_dir = 0


func _ready():
 pass
func get_input():
	if Input.is_action_pressed("ui_up"):
		thrust = Vector2(engine_thrust, 0)
	else:
		thrust = Vector2(0,0) 
	if Input.is_action_pressed("ui_down"):
		thrust = Vector2(-engine_thrust, 0)
	rotation_dir = 0
	if Input.is_action_pressed("ui_right"):
		rotation_dir += 1
	if Input.is_action_pressed("ui_left"):
		rotation_dir -= 1

func _process(delta):
	get_input()

func _physics_process(delta):
	
	set_applied_force(thrust.rotated(rotation))
	set_applied_torque(rotation_dir * spin_thrust)
