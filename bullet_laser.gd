extends Area2D

var speed =  200
var dir = Vector2()
func _ready():
	$life_timer.start()
	$AudioStreamPlayer.play()
	
	
func _process(delta):
	translate(dir * speed * delta)
	rotation = dir.angle()
#	var velocity = Vector2(speed * delta,0)
#	position +=velocity.rotated(rotation)

#func _on_Timer_timeout():
#	queue_free()
#
#
#func _on_Bullet_body_entered(body):
#	if (body.is_in_group("Obstacle")):
#		queue_free()
#	elif (body.is_in_group("Enemy")):
#		body.shot()
#		body.queue_free()
#		GLOBAL._enemy_killed() 


func _on_Timer_timeout():
	queue_free() # Replace with function body.


func _on_bullet_laser_area_entered(area):
	print("hit" + str(rand_range(1,100)))
	if area.has_method("_hit_done"):
		area._hit_done()
		print("hit_done")
		queue_free() 


#func _on_bullet_laser_body_entered(body):
#	if body.has_method("hit_done"):
#		body.hit_done()
#		print("hit")
#		queue_free() 
