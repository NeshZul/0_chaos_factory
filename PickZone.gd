extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var items_in_range = {}
func _on_PickZone_body_entered(body):
	if body.has_method("pick_up_item"):
		items_in_range[body] = body
		var pickup_item = items_in_range.values()[0]
		pickup_item.pick_up_item(self)
	
		items_in_range.erase(pickup_item)

func _on_PickZone_body_exited(body):
	if items_in_range.has(body):
		items_in_range.erase(body)
