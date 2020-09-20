extends CanvasLayer
var ship1 
var scene
onready var camera =$rts_camera

func _ready():
	pass # Replace with function body.


func _on_delete_pressed():
	if ship1 != null:
		ship1.free()
		camera.current = true
		camera.position = Vector2.ZERO
	else:
		 return

func _on_test_ship_pressed():
	if ship1 != null:
		return
	else:
		scene = load("res://Ship.tscn")
		ship1 = scene.instance()
		get_parent().add_child(ship1)
		ship1.position = Vector2(400,200)
		
		

func _on_test_ship_2_pressed():
	if ship1 != null:
		return
	else:
		scene = load("res://Ship2.tscn")
		ship1 = scene.instance()
		get_parent().add_child(ship1)
		ship1.position = Vector2(400,200)

func _on_spawn_base_ship_pressed():
	if ship1 != null:
		return
	else:
		scene = load("res://PlayerShip.tscn")
		ship1 = scene.instance()
		get_parent().add_child(ship1)
		ship1.position = Vector2(400,200)

func _on_rts_camera_onoff_pressed():
	if camera.current != true :
		camera.current = true
	else:
		camera.current = false
		camera._set_state_ZOOM_1()
