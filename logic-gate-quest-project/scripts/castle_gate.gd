extends StaticBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _travel_level_1() -> void:
	get_tree().change_scene_to_file("res://levels/throne_room.tscn")

# when the player was into the gates area this signals taking them to the throne room
func _on_area_2d_body_entered(_body: Node2D) -> void:
	call_deferred("_travel_level_1")
