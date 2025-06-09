extends Control

@onready var level_1: Button = $GridContainer/level1
@onready var level_2: Button = $GridContainer/level2
@onready var level_3: Button = $GridContainer/level3
@onready var level_4: Button = $GridContainer/level4
@onready var level_5: Button = $GridContainer/level5
@onready var level_6: Button = $GridContainer/level6
@onready var level_7: Button = $GridContainer/level7
@onready var level_8: Button = $GridContainer/level8
@onready var level_9: Button = $GridContainer/level9
@onready var level_10: Button = $GridContainer/level10
@onready var level_11: Button = $GridContainer/level11
@onready var level_12: Button = $GridContainer/level12
@onready var level_13: Button = $GridContainer2/level13
@onready var level_14: Button = $GridContainer2/level14
@onready var level_15: Button = $GridContainer2/level15
@onready var level_16: Button = $GridContainer2/level16
@onready var level_17: Button = $GridContainer2/level17
@onready var level_18: Button = $GridContainer2/level18
@onready var level_19: Button = $GridContainer2/level19
@onready var level_20: Button = $GridContainer2/level20
@onready var dragons_lair: Button = $"GridContainer2/dragons lair"


func _ready() -> void:
	_show_completed_levels()
	SongManager.sing_scene_song("level")

# ensure only available levels are usable
func _show_completed_levels() -> void:
	var button_list = [level_1, level_2, level_3, level_4, 
	level_5, level_6, level_7, level_8, 
	level_9, level_10, level_11, level_12, 
	level_13, level_14, level_15, level_16,
	level_17, level_18, level_19,
	level_20, dragons_lair]
	
	# disable buttons for levels that havent beeen completed / are not available
	for i in range(21):
		var button = button_list[i]
		if i > 0:
			var level_completed = SaveManager.get_level_data(i).get("complete", 0)
			if level_completed == 0:
				button.disabled = true

# button signal handling

func _on_throne_room_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/throne_room.tscn")

func _on_title_screen_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/title_screen.tscn")

func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/tutorial.tscn")

func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_1.tscn")

func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_2.tscn")

func _on_level_3_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_3.tscn")

func _on_level_4_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_4.tscn")

func _on_level_5_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_5.tscn")

func _on_level_6_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_6.tscn")

func _on_level_7_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_7.tscn")

func _on_level_8_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_8.tscn")

func _on_level_9_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_9.tscn")

func _on_level_10_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_10.tscn")

func _on_level_11_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_11.tscn")

func _on_level_12_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_12.tscn")

func _on_level_13_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_13.tscn")

func _on_level_14_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_14.tscn")

func _on_level_15_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_15.tscn")

func _on_level_16_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_16.tscn")

func _on_level_17_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_17.tscn")

func _on_level_18_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_18.tscn")

func _on_level_19_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_19.tscn")

func _on_level_20_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_20.tscn")

func _on_dragons_lair_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_21.tscn")
