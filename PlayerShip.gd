extends KinematicBody2D


var bullet = load("res://bullet_laser.tscn")

var score = 0
var dir
var turn_speed = 0.02

var speed = 1800
var friction = 0.008
var acceleration = 0.004
var velocity = Vector2.ZERO


onready var damp_effect = $Thrust_patricles.get_process_material()
onready var gun_laser = $gun_laser
onready var tween = $Tween
onready var camera =$Camera2D

var zoom_1 = Vector2(1,1)
var zoom_5 = Vector2(5,5)
var zoom_max = Vector2(30,30)

func _ready():
	GameState.player = self
func _process(delta):
	var gun_laser_pos = gun_laser.position
	damp_effect.damping = 100 - (velocity.length())
#	print(velocity.length())
	_rotate()
	var input_velocity = Vector2.ZERO
	# Check input for "desired" velocity
	if Input.is_action_pressed("lean_right"):
		input_velocity.x += 1
	if Input.is_action_pressed("lean_left"):
		input_velocity.x -= 1
	if Input.is_action_pressed("back"):
		input_velocity.y += 1
	if Input.is_action_pressed("forward"):
		input_velocity.y -= 1


	input_velocity = input_velocity.normalized() * speed

	if Input.is_action_just_pressed("friction_off"):
		friction = 0.000000000000001
	if Input.is_action_just_released("friction_off"):
		friction = 0.008
	if Input.is_action_just_released("click_right"):
		var dir_bullet = (get_global_mouse_position() - position).normalized()
		var instance_bullet= bullet.instance()
		instance_bullet.position = gun_laser.get_global_transform().origin
		instance_bullet.rotation = gun_laser.rotation
		if velocity.length() > 300:
			instance_bullet.dir = dir_bullet * velocity.length()/100
		else:
			instance_bullet.dir = dir_bullet *2
		get_parent().add_child(instance_bullet)

	# If there's input, accelerate to the input velocity
	if input_velocity.length() > 0:
		velocity = velocity.linear_interpolate(input_velocity, acceleration)
	else:
		# If there's no input, slow down to (0, 0)
		velocity = velocity.linear_interpolate(Vector2.ZERO, friction)
	velocity = move_and_slide(velocity)

func _rotate():
	dir = get_angle_to(get_global_mouse_position())
	if abs(dir) < turn_speed:
		rotation += dir
	else:
		if dir > 0: rotation += turn_speed #clockwise
		if dir < 0: rotation -= turn_speed #anit - clockwise

func _input(event):
	if event is InputEventMouseButton:
		if camera.zoom == zoom_1 and event.button_index == BUTTON_WHEEL_DOWN:
			## smooth
			tween.stop_all()
			tween.interpolate_property(camera, "zoom" , zoom_1,  zoom_5, 0.25,Tween.TRANS_CUBIC )
			tween.start()
		if camera.zoom == zoom_5 and event.button_index == BUTTON_WHEEL_UP:
			tween.stop_all()
			tween.interpolate_property(camera, "zoom" , zoom_5,  zoom_1, 0.25,Tween.TRANS_CUBIC )
			tween.start()
