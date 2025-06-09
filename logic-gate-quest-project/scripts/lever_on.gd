extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var label: Label = $Label
@onready var switch: AudioStreamPlayer = $switch

var frame_0 = preload("res://art/objects/power/lever on.png") 
var frame_1 = preload("res://art/objects/power/lever off.png")

signal state_changed(state: bool)

# start with signal being true, also check for annotation
func _ready() -> void:
	call_deferred("emit_signal", "state_changed", true)
	if !PersistantSettings.get_circuit_annotation():
		label.hide()

# when player interacts with lever send the opposite of current input and switch to next sprite while flipping collision
func on_interact():
	switch.play()
	var power = sprite_2d.texture == frame_1
	emit_signal("state_changed", power)
	if sprite_2d.texture == frame_0:
		sprite_2d.texture = frame_1
		collision_polygon_2d.scale.x *= -1
	else:
		sprite_2d.texture = frame_0
		collision_polygon_2d.scale.x *= -1
