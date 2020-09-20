extends KinematicBody2D

onready var TweenNode = get_node("Tween")

var speed = 200  # speed in pixels/sec
var velocity = Vector2.ZERO
var final_transform_x

# apply rotation
func _set_rotation(new_transform):
	
	# apply tweened x-vector of basis
	self.transform.x = new_transform
	
	# make x and y orthogonal and normalized
	self.transform = self.transform.orthonormalized()


func _process(delta):	
	# target to look at
	var target = get_global_mouse_position()
	
	# initial and final x-vector of basis
	var initial_transform_x = self.transform.x
	final_transform_x = (target - self.global_position).normalized()
	
	# interpolate
	TweenNode.interpolate_method(self, '_set_rotation', initial_transform_x, final_transform_x, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	TweenNode.start()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity *= final_transform_x.normalized() *speed
	# Make sure diagonal movement isn't faster

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
