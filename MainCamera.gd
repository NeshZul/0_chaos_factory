extends Camera2D

var is_dragging = false
var selected_units = []

var mousePos = Vector2()
var mousePosGlobal = Vector2()
var start = Vector2()
var startv = Vector2()
var end = Vector2()
var endv  = Vector2()
onready var rectD : ColorRect = $'../GUI/ColorRect'
signal area_selected

export var speed = 10.0
export var zoomFactor = 1.0
export var zoomMargin = 0.1
export var zoomSpeed = 30

var zooming = false

export var zoomMin = 0.5
export var zoomMax = 100.0
var zoomPos = Vector2()

func _ready():
	pass
func _process(delta):
	var inputx = (int(Input.is_action_pressed("ui_right"))
	-int(Input.is_action_pressed("ui_left")))
	var inputy = (int(Input.is_action_pressed("ui_down"))
	-int(Input.is_action_pressed("ui_up")))
	position.x +=inputx * speed
	position.y +=inputy * speed
	
	#zoom in
	zoom.x = lerp(zoom.x, zoom.x * zoomFactor, zoomSpeed * delta)
	zoom.y = lerp(zoom.y, zoom.y * zoomFactor, zoomSpeed * delta)
	zoom.x = clamp(zoom.x,zoomMin,zoomMax)
	zoom.y = clamp(zoom.y,zoomMin,zoomMax)
	
	if Input.is_action_just_pressed("ui_mouseleft"):
		start= mousePosGlobal
		startv = mousePos
		is_dragging= true
	if is_dragging:
		end =mousePosGlobal
		end= mousePos
		draw_area()
	if Input.is_action_just_released("ui_mouseleft"):
		if startv.distance_to(mousePos) > 20:
			end = mousePosGlobal
			endv=mousePos
			is_dragging = false
			draw_area(false) 
			emit_signal("area_selected")
		else:
			end =start
			is_dragging = false
			draw_area(false) 
	
func draw_area(s = true):
	rectD.rect_size = Vector2(abs(startv.x-endv.x), abs(startv.y-endv.y) )
	var pos = Vector2()
	pos.x = min(startv.x,endv.x)
	pos.y = min(startv.y,endv.y)
	pos.y -= OS.window_size.y
	rectD.rect_position = pos
	rectD.rect_size *= int(s)
	
func _input(event):
	if abs(zoomPos.x - get_global_mouse_position().x) > zoomMargin:
		zoomFactor = 1.0
	if abs(zoomPos.y - get_global_mouse_position().y) > zoomMargin:
		zoomFactor = 1.0
		
	if event is InputEventMouseButton:
		if event.is_pressed():
			zooming = true
			if event.button_index ==BUTTON_WHEEL_UP:
				zoomFactor -=0.01 *zoomSpeed
				zoomPos = get_global_mouse_position()
			if event.button_index ==BUTTON_WHEEL_DOWN:
				zoomFactor +=0.01 *zoomSpeed
				zoomPos = get_global_mouse_position()
			else:
				zooming = false
				
	if event is InputEventMouse:
		mousePos = event.position
		mousePosGlobal = get_global_mouse_position()
			



