extends Sprite2D

@onready var sprite_2d: Sprite2D = $"."

var frame_0 = preload("res://art/objects/wire/outlet off.png") 
var frame_1 = preload("res://art/objects/wire/outlet on.png")

# swaps the sprite depending on the inputs signal
func _switch(state: bool) -> void:
	if state:
		sprite_2d.texture = frame_1
	else:
		sprite_2d.texture = frame_0

func _change_state(state: bool) -> void:
	_switch(state)
