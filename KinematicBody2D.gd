extends KinematicBody2D

var wheel_base = 60
var steer_angle = 15
var velocity =Vector2.ZERO
var steer_direction


func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	
	
	
	
func get_input():
	var turn = 0
	if Input.is_action_pressed("ui_right"):
		turn += 1
	if Input.is_action_pressed("ui_left"):
		turn -= 1
	steer_direction = turn * steer_angle
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity = transform.x * 500


func steering():
	pass
