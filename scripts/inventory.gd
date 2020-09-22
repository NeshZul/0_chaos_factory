extends Node

var Inv_slots = 20
var inv_init = load("res://inventory_cont.tscn")

var inventory ={
	0:["keramdit",1]
}
	
func add_item(item_name, item_quantity):
	for item in inventory:
		if inventory[item][0] ==item_name:
			inventory[item][1] +=item_quantity
			return
			
	for i in range(Inv_slots):
		if inventory.has(i) == false:
			inventory[i] = [item_name, item_quantity]
			return
			
	inv_init.inv_initilaize()

#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
