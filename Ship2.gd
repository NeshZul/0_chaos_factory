extends KinematicBody2D

var speed = 400

export var friction = 0.4
export var acceleration = 200
var rotation_direction
export (float) var rotation_speed  = 0.3
var velocity = Vector2()

onready var tween = $Tween
onready var camera =$Camera2D

var zoom_1 = Vector2(1,1)
var zoom_5 = Vector2(5,5)
var zoom_max = Vector2(30,30)

func get_input(delta):
	rotation_direction = 0
	velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		rotation_direction -= 1
	if Input.is_action_pressed('ui_right'):
		rotation_direction += 1
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




	if Input.is_action_pressed('ui_down'):
		velocity = Vector2(-speed , 0).rotated(rotation)
	if Input.is_action_pressed('ui_up'):
		velocity = Vector2(speed , 0).rotated(rotation)


func _process(delta):
	get_input(delta)
	rotation += rotation_direction * rotation_speed * delta
	
#	if velocity.length() > 0:
#		velocity = velocity.linear_interpolate(velocity, acceleration)
#	else:
#		# If there's no input, slow down to (0, 0)
#		velocity = velocity.linear_interpolate(Vector2.ZERO, friction)
	print(velocity)
	velocity = move_and_slide(velocity)


#func get_input():
#	var input = Vector2()
#	if Input.is_action_pressed('ui_right'):
#		input.x += 1
#	if Input.is_action_pressed('ui_left'):
#		input.x -= 1
#	if Input.is_action_pressed('ui_down'):
#		input.y += 1
#	if Input.is_action_pressed('ui_up'):
#		input.y -= 1
#	return input
#
#func _physics_process(delta):
#	var direction = get_input()
#	if direction.length() > 0:
#		velocity = lerp(velocity, direction.normalized() * speed, acceleration)
#	else:
#		velocity = lerp(velocity, Vector2.ZERO, friction)
#	velocity = move_and_slide(velocity)
