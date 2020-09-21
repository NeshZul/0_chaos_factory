extends Node2D

const slot_class = preload("res://slot.gd")
onready var inv_slots =$border/slot_back/VBoxContainer/MainElements/GridContainer
var hold_item = null

func _ready():
	for inv_slot in inv_slots.get_children():
		inv_slot.connect("gui_input", self, "slot_gui_input",[inv_slot])

func slot_gui_input(event :InputEvent, slot: slot_class):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if hold_item !=null:
				if !slot.item: # plasing
					slot._put_to_slot(hold_item)
					hold_item = null
				else: # swapping
					var temp_item = slot.item
					slot._pick_from_slot()
					temp_item.global_position = event.global_position
					slot._put_to_slot(hold_item)
					hold_item = temp_item
			elif slot.item:
					hold_item =slot.item
					slot._pick_from_slot()
					hold_item.global_position = get_global_mouse_position()

func _input(event):
	if hold_item :
		hold_item.global_position = get_global_mouse_position()


