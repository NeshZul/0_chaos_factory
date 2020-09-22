extends Node2D

var item_name
var item_quantity


func _ready():
#	$TextureRect.texture = load("res://data/"+item_name+".png")
#	var stack_size = int(JSON_Data.item_data[item_name]["ItemStackSize"])
#
#	if stack_size == 1:
#		$Label.visible = false
#	else:
#		$Label.text = String(item_quantity)
	pass
		
		
func set_item (nm, qt):
	item_name = nm
	item_quantity = qt
	$TextureRect.texture =load("res://data/"+item_name+".png")
	var stack_size = int(JSON_Data.item_data[item_name]["ItemStackSize"])
	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.text = String(item_quantity)
		
func add_item_quantity(amount):
	item_quantity += amount
	$Label.text = String(item_quantity)
	
func remove_item_quantity(amount):
	item_quantity -= amount
	$Label.text = String(item_quantity)
func _process(delta):
	pass
