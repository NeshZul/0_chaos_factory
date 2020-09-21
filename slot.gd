extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var item_class = preload("res://item.tscn")
var item =null
# Called when the node enters the scene tree for the first time.
func _ready():
	if randi() % 2 == 0:
		item = item_class.instance()
		add_child(item)
		
func _pick_from_slot():
	remove_child(item)
	var Inv_node =find_parent("inventory_cont")
	Inv_node.add_child(item)
	item = null

func _put_to_slot(new_item):
	item = new_item
	item.position = Vector2.ZERO
	var Inv_node =find_parent("inventory_cont")
	Inv_node.remove_child(item)
	add_child(item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
