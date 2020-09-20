extends Area2D

onready var patricles = load("res://explosion.tscn")
onready var timer =$Timer
onready var count =$Label
onready var sound =$AudioStreamPlayer 
var max_hp = 1000
var current_hp 
func _process(delta):
	
	if current_hp <= 0 :
		_boom()
		self.hide() 
		get_parent().remove_child(self)
		self.queue_free()
		
func _ready():
	current_hp = max_hp
	count.hide()
	
func _on_hit(damage):
	current_hp -=damage
	count.show()
	count.text = str(round(current_hp))+"/"+str(round(max_hp))
	print(current_hp)
	
func _boom():
	var explosion = patricles.instance()
	get_parent().add_child(explosion)
	explosion.position = self.position
	explosion.one_shot = true
	explosion.emitting = true
