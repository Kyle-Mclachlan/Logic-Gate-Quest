extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label

var frame_0 = preload("res://art/objects/moveableMonoliths/i slot off.png") 
var frame_1 = preload("res://art/objects/moveableMonoliths/i slot left.png") 
var frame_2 = preload("res://art/objects/moveableMonoliths/i slot right.png") 
var frame_3 = preload("res://art/objects/moveableMonoliths/i slot on.png")

var frame_4 = preload("res://art/objects/moveableMonoliths/i and off.png") 
var frame_5 = preload("res://art/objects/moveableMonoliths/i and left.png") 
var frame_6 = preload("res://art/objects/moveableMonoliths/i and right.png") 
var frame_7 = preload("res://art/objects/moveableMonoliths/i and on.png") 

var frame_8 = preload("res://art/objects/moveableMonoliths/i or off.png") 
var frame_9 = preload("res://art/objects/moveableMonoliths/i or left.png") 
var frame_10 = preload("res://art/objects/moveableMonoliths/i or right.png") 
var frame_11 = preload("res://art/objects/moveableMonoliths/i or on.png") 

var frame_12 = preload("res://art/objects/moveableMonoliths/i xor off.png") 
var frame_13 = preload("res://art/objects/moveableMonoliths/i xor left.png") 
var frame_14 = preload("res://art/objects/moveableMonoliths/i xor right.png") 
var frame_15 = preload("res://art/objects/moveableMonoliths/i xor on.png") 

var left = false
var right = false
var stone = ""

signal monolith_changed(state: bool)

# check for annotated setting
func _ready() -> void:
	if !PersistantSettings.get_circuit_annotation():
		label.hide()

# when input or stone change update the slots state
func _change_frame() -> void:
	if stone == "":
		_empty_slot()
	elif stone == "and":
		_and_slot()
	elif stone == "or":
		_or_slot()
	elif stone == "xor":
		_xor_slot()

# logic gate states for sprites and output signals

func _empty_slot() -> void:
	label.text = "Slot"
	if left and right:
		sprite_2d.texture = frame_3
		emit_signal("monolith_changed", false)
	elif left:
		sprite_2d.texture = frame_1
		emit_signal("monolith_changed", false)
	elif right:
		sprite_2d.texture = frame_2
		emit_signal("monolith_changed", false)
	else:
		sprite_2d.texture = frame_0
		emit_signal("monolith_changed", false)

func _and_slot() -> void:
	label.text = "And Gate"
	if left and right:
		sprite_2d.texture = frame_7
		emit_signal("monolith_changed", true)
	elif left:
		sprite_2d.texture = frame_5
		emit_signal("monolith_changed", false)
	elif right:
		sprite_2d.texture = frame_6
		emit_signal("monolith_changed", false)
	else:
		sprite_2d.texture = frame_4
		emit_signal("monolith_changed", false)

func _or_slot() -> void:
	label.text = "Or Gate"
	if left and right:
		sprite_2d.texture = frame_11
		emit_signal("monolith_changed", true)
	elif left:
		sprite_2d.texture = frame_9
		emit_signal("monolith_changed", true)
	elif right:
		sprite_2d.texture = frame_10
		emit_signal("monolith_changed", true)
	else:
		sprite_2d.texture = frame_8
		emit_signal("monolith_changed", false)

func _xor_slot() -> void:
	label.text = "Xor Gate"
	if left and right:
		sprite_2d.texture = frame_15
		emit_signal("monolith_changed", false)
	elif left:
		sprite_2d.texture = frame_13
		emit_signal("monolith_changed", true)
	elif right:
		sprite_2d.texture = frame_14
		emit_signal("monolith_changed", true)
	else:
		sprite_2d.texture = frame_12
		emit_signal("monolith_changed", false)

#signal handling for inputs and stone changes

func get_stone_type(given_stone):
	stone = given_stone.get_type()
	_change_frame()

func clear_stone():
	stone = ""
	_change_frame()

func _change_left_state(state: bool) -> void:
	left = state
	_change_frame()

func _change_right_state(state: bool) -> void:
	right = state
	_change_frame()
