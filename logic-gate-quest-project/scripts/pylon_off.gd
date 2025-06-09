extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var label: Label = $Label

signal pylon_changed(state: bool)

# sends an unpowered signal at the start then doesnt change
func _ready() -> void:
	call_deferred("_send_signal")
	if !PersistantSettings.get_circuit_annotation():
		label.hide()

func _send_signal() -> void:
	emit_signal("pylon_changed", true)
