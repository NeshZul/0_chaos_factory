extends KinematicBody2D
var accel = 200
var speed = 800
var velocity = Vector2.ZERO
var item_name
var player = null
var being_picked_up = false
onready var inv_scene =load("res://inventory_cont.tscn")
func _ready():
	item_name = "keramdit"

func _process(delta):
	if being_picked_up == false:
		velocity = Vector2.ZERO
	else:
		var direction = global_position.direction_to(GameState.player.global_position)
		velocity = velocity.move_toward(direction * speed, accel * delta)
		
		var distance = global_position.distance_to(GameState.player.global_position)
		if distance < 100:
			Inventory.add_item(item_name,1)
			queue_free()
	velocity = move_and_slide(velocity)

func pick_up_item(body):
	player = body
	being_picked_up = true
