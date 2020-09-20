extends Camera2D
onready var tween =$Tween
const MOVE_SPEED = 1000
var state = zoom_1

var zoom_1 = Vector2(1,1)
var zoom_5 = Vector2(5,5)
var zoom_max = Vector2(30,30)

var camera = self
var m_pos
func _ready():
	state = zoom_1

func _process(delta):
	_move(delta)
	
func _move(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("lean_left") :
		velocity.x -=1
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("lean_right") :
		velocity.x +=1
	if Input.is_action_pressed("ui_up") or Input.is_action_pressed("forward") :
		velocity.y -=1
	if Input.is_action_pressed("ui_down") or Input.is_action_pressed("back") :
		velocity.y +=1

	if state == zoom_1:
		translate(velocity * MOVE_SPEED * delta)
	if state == zoom_5:
		translate(velocity * MOVE_SPEED * delta * 3)
	if state == zoom_max:
		translate(velocity * MOVE_SPEED * delta * 25)


func _set_state_zoom_1():
	state = zoom_1
func _input(event):
	if event is InputEventMouseButton:
		if camera.zoom == zoom_1 and event.button_index == BUTTON_WHEEL_DOWN:
			## smooth
			tween.stop_all()
			tween.interpolate_property(camera, "zoom" , zoom_1,  zoom_5, 0.4)
			tween.start()
			state = zoom_5

		if camera.zoom == zoom_5 and event.button_index == BUTTON_WHEEL_UP:
			tween.stop_all()
			tween.interpolate_property(camera, "zoom" , zoom_5,  zoom_1, 0.4)
			tween.start()
			state = zoom_1

		if camera.zoom == zoom_5 and event.button_index == BUTTON_WHEEL_DOWN:
			tween.stop_all()
			tween.interpolate_property(camera, "zoom" , zoom_5,  zoom_max, 1)
			tween.start()
			state = zoom_max

		if camera.zoom == zoom_max and event.button_index == BUTTON_WHEEL_UP:
			tween.stop_all()
			tween.interpolate_property(camera, "zoom" , zoom_max,  zoom_5, 1)
			tween.start()
			state = zoom_5
#		if camera.zoom == zoom_max and event.button_index == BUTTON_MIDDLE:
#			camera.position  = translate(get_global_mouse_position())
##			tween.stop_all()
##			tween.interpolate_property(camera, "zoom" , zoom_max,  zoom_5, 1)
##			tween.start()
##			state = zoom_5

	if Input.is_action_pressed("ui_accept"):
		tween.stop_all()
		tween.interpolate_property(camera, "zoom" , zoom_1,  zoom_5, 0.4)
		tween.start()
		self.position = Vector2.ZERO
		state = zoom_5

