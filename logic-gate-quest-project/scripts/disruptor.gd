extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label
@onready var spark: CPUParticles2D = $spark

var frame_0 = preload("res://art/objects/trap/disruptor off.png")
var frame_1 = preload("res://art/objects/trap/disruptor on.png")
var frame_2 = preload("res://art/objects/trap/disruptor on off.png")

var activated = false
var startOff = false

signal disruptor_activated(state: bool)

# check settings for annotation
func _ready() -> void:
	if !PersistantSettings.get_circuit_annotation():
		label.hide()

#disruptor only sends its disrupt signal onece, then stays active, any input changes will then just be visual
func _change_frame(state: bool) -> void:
	if activated and state:
		sprite_2d.texture = frame_1
	elif activated and not state:
		sprite_2d.texture = frame_2
	elif state and not activated:
		emit_signal("disruptor_activated", true)
		sprite_2d.texture = frame_1
		spark.emitting = true
		activated = true

# when signal triggered start disrupt
func _change_state(state: bool) -> void:
	_change_frame(state)

# small check for final level to get disruptor to ignore initially positive signal, before disrupting when player signals it
func _change_state_special_case(state: bool) -> void:
	if not startOff:
		startOff = true
	else:
		_change_frame(state)
