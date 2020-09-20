extends Node

var rand = RandomNumberGenerator.new()
var portal_scene = load("res://portal.tscn")
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass


func _on_portal_pressed():
	var portal = portal_scene.instance()
	rand.randomize()
	var x = rand.randf_range(-3000, 3000)
	var y = rand.randf_range(-3000, 3000)
	portal.position.x = x
	portal.position.y = y
	add_child(portal)
	pass # Replace with function body.
