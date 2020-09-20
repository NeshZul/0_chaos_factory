extends RayCast2D

export var is_casting = false setget set_is_casting
onready var timer =$Timer
var damage = 400

func _ready():
	$Line2D.width = 0
	self.enabled = false
func _physics_process(delta):
	var cast_point = cast_to
#	force_raycast_update()
	$Collision_particles.emitting = is_colliding()
	if is_colliding():
		cast_point =to_local(get_collision_point())
		$Collision_particles.global_rotation = get_collision_point().angle() * PI/2
		$Collision_particles.position = cast_point
		if get_collider().has_method("_hit_done"):
			get_collider()._hit_laser_done()
		if self.get_collider().is_in_group("asteroids"):
			get_collider()._on_hit(damage * delta)
			
	$Line2D.points[1] = cast_point
	
func _unhandled_input(event):
	if Input.is_action_just_pressed("Click") :
		timer.start()
		self.is_casting = true
		self.enabled = true
	if Input.is_action_just_released("Click") :
		timer.start()
		self.is_casting = false
		self.enabled = false
func set_is_casting(cast):  #bool
	is_casting = cast
	$Cast_start_particles.emitting = is_casting  # because boll false or true its worked
	$AudioStreamPlayer.playing = is_casting
	
	if is_casting:
		_appear()
	else:
		$Collision_particles.emitting = false
		$AudioStreamPlayer.stop()
		_disappear()
	set_physics_process(is_casting)
	
func _appear():
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", 0, 3.0, 0.4)
	$Tween.start()
	
func _disappear():
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", 3.0, 0, 0.1)
	$Tween.start()
