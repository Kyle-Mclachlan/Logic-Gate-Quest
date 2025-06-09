extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label

var frame_0 = preload("res://art/objects/monolith/not off.png")
var frame_1 = preload("res://art/objects/monolith/not on.png")

signal monolith_changed(state: bool)

#check for annotation settings
func _ready() -> void:
	if !PersistantSettings.get_circuit_annotation():
		label.hide()

# logic for NOT monoliths outputs based on inputs
func _change_frame(state: bool) -> void:
	if state:
		sprite_2d.texture = frame_1
		emit_signal("monolith_changed", false)
	else:
		sprite_2d.texture = frame_0
		emit_signal("monolith_changed", true)

# input signal handling
func _change_state(state: bool) -> void:
	_change_frame(state)
