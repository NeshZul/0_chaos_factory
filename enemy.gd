extends Node2D

onready var raycast = $RayCast2D
onready var anim_blood_node = $blood_hit
onready var anim_blood_exp_node = $anim_exp
onready var anim_blood_spr = $blood
onready var anim_blood_exp_spr = $exp_blood
onready var base_spr = $Sprite

onready var timer = $Timer
var speed = 420
var velocity =Vector2()
var health = 150
var player = GameState.player
var rotation_speed = 190.0
func _ready():

	pass # Replace with function body.

func _process(delta):
	if raycast != null :
		raycast.rotation_degrees += rotation_speed * delta
		if raycast.is_colliding():
			if raycast.get_collider().is_in_group("player"):
				speed = 5000
				base_spr.hide()
				timer.start()
				print("killed")
				anim_blood_exp_spr.show()
				anim_blood_node.play("exp_blood")
				raycast.queue_free()

	
	if GameState.player !=null :
		look_at(GameState.player.global_position)
		velocity = global_position.direction_to(GameState.player.global_position)
		global_position += velocity * speed * delta 

func _hit_done():
	health -=20
	anim_blood_spr.show()
	anim_blood_node.play("blood")
	anim_blood_node.play_backwards("blood")
	print(health)
	if health <= 0:
		base_spr.hide()
		timer.start()
		print("killed")
		anim_blood_exp_spr.show()
		anim_blood_node.play("exp_blood")
	if health == -20:
		return
		

func _hit_laser_done():
	health = 0
	base_spr.hide()
	timer.start()
	print("killed")
	anim_blood_exp_spr.show()
	anim_blood_node.play("exp_blood")
func _on_Timer_timeout():
	queue_free()


