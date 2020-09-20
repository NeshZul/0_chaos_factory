extends Node2D

var enemy_scene =load("res://enemy.tscn")
onready var timer = $Timer
onready var timer_dead =$Timer_dead
onready var timer_die = $Timer_die
onready var timer_rotation = $Timer_rotation
onready var anim =$AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play_backwards("fade")
	anim.queue("portal")
	anim.animation_set_next("portal", "fade")
	timer.start()
	timer_rotation.start()
	
	


func _on_Timer_timeout():
	randomize()
	var enemy = enemy_scene.instance()
	get_parent().add_child(enemy)
	enemy.position = self.global_position + Vector2(rand_range(-100,100),rand_range(-100,100)) 
	
func _on_Timer_dead_timeout():

	anim.play("fade")
	timer_die.start()
	timer.stop()



func _on_Timer_die_timeout():
		self.queue_free()


func _on_Timer_rotation_timeout():
	anim.play("portal")
