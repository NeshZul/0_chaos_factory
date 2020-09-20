extends Node
const  MAX_SPEED: = 100.0
const  SLOW_RADIUS: = 5
const  MASS: = 10 #seek force
export (float) var seek_factor = 1



static func follow(
		velocity : Vector3,
		global_position3D : Vector3,
		target_position3D : Vector3,
		max_speed : = MAX_SPEED,
		mass : = MASS
		
	) -> Vector3:
	var desired_velocity: = (target_position3D-global_position3D).normalized() * max_speed
	var steering:  = (desired_velocity - velocity) / mass
	return velocity + steering

static func flee(
		velocity : Vector3,
		global_position3D : Vector3,
		target_position3D : Vector3,
		max_speed : = MAX_SPEED,
		mass : = MASS
	) -> Vector3:
	var desired_velocity: = (target_position3D-global_position3D).normalized() * max_speed
	var steering:  = (-1*desired_velocity - velocity) / mass
	return velocity + steering
static func arriveTo(
		velocity : Vector3,
		global_position3D : Vector3,
		target_position3D : Vector3,
		max_speed : = MAX_SPEED,     #speed
		slow_radius: = SLOW_RADIUS,  #radius for brake
		mass : = MASS                #ammount of "drift"
	) -> Vector3:
		
	var to_target: = global_position3D.distance_to(target_position3D)
	var desired_velocity: = (target_position3D-global_position3D).normalized() * max_speed
	if to_target < slow_radius :
		desired_velocity *= (to_target/slow_radius) * 0.4 + 1.0
	var steering:  = (desired_velocity - velocity) / mass
	return velocity + steering
