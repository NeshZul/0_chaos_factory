extends KinematicBody2D


onready var tween = $Tween
onready var camera =$Camera2D

var zoom_1 = Vector2(1,1)
var zoom_5 = Vector2(5,5)
var zoom_max = Vector2(30,30)

var dir
var turn_speed = 0.02
export var speed = 200
export var friction = 0.5
export var acceleration = 0.5

var velocity = Vector2()

#func get_input():
#	_set_rotation(velocity)
#	rotation_dir = 0
#	velocity = Vector2.ZERO
##	if Input.is_action_pressed('ui_right'):
##		rotation_dir += 1
##	if Input.is_action_pressed('ui_left'):
##		rotation_dir -= 1
#	if Input.is_action_pressed('ui_down'):
#		 velocity = Vector2(-speed, 0).rotated(rotation)
#	if Input.is_action_pressed('ui_up'):
#		velocity = Vector2(speed, 0).rotated(rotation)
#
#func _physics_process(delta):
#
#	var target = get_global_mouse_position()
#
#	# initial and final x-vector of basis
#	var initial_direction= self.transform.x
#	final_direction = (target - self.global_position).normalized()
#
#	# interpolate
#	tween.interpolate_method(self, '_set_rotation', initial_direction, final_direction , 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
#	tween.start()
#
#	get_input()
##	rotation += rotation_dir * 1 * delta
#
#
##	if direction.length() > 0:
##		velocity = lerp(velocity, direction.normalized() * speed, acceleration)
##	else:
##		velocity = lerp(velocity, Vector2.ZERO, friction)
#	velocity = move_and_slide(velocity)

func get_input():
	look_at(get_global_mouse_position())
	velocity = Vector2()
	
	if Input.is_action_pressed('ui_down'):
		velocity = Vector2(-speed, 0).rotated(rotation)
	if Input.is_action_pressed('ui_up'):
		velocity = Vector2(speed, 0).rotated(rotation)
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

func _physics_process(delta):
	_rotate()
	get_input()
	if velocity.length() > 0:
		velocity = velocity.linear_interpolate(velocity, acceleration)
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
