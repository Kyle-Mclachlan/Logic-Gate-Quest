extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label

var frame_0 = preload("res://art/objects/monolith/and off.png") 
var frame_1 = preload("res://art/objects/monolith/and left.png") 
var frame_2 = preload("res://art/objects/monolith/and right.png") 
var frame_3 = preload("res://art/objects/monolith/and on.png") 

var left = false
var right = false

signal monolith_changed(state: bool)

#check for annotation settings
func _ready() -> void:
	if !PersistantSettings.get_circuit_annotation():
		label.hide()

# logic for AND monoliths outputs based on inputs
func _change_frame() -> void:
	if left and right:
		sprite_2d.texture = frame_3
		emit_signal("monolith_changed", true)
	elif left:
		sprite_2d.texture = frame_1
		emit_signal("monolith_changed", false)
	elif right:
		sprite_2d.texture = frame_2
		emit_signal("monolith_changed", false)
	else:
		sprite_2d.texture = frame_0
		emit_signal("monolith_changed", false)

# input signal handling

func _change_left_state(state: bool) -> void:
	left = state
	_change_frame()

func _change_right_state(state: bool) -> void:
	right = state
	_change_frame()
