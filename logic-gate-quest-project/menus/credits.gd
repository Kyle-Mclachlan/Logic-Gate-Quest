extends Control

@onready var v_box_container: VBoxContainer = $VBoxContainer

func _ready() -> void:
	# start credits music
	SongManager.sing_scene_song("credits")

# this scrolls the credits up until they reachthe end, the verticle box is between 2 sprites to give the impression of text staying within the laid out border
func _process(delta):
	if v_box_container.position.y > -1070:
		v_box_container.position.y -= 30 * delta

# title button handling
func _on_title_screen_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/title_screen.tscn")
