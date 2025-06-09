extends Control

@onready var load_game: Button = $"CanvasLayer/VBoxContainer/Load Game"
@onready var select_level: Button = $"CanvasLayer/VBoxContainer/Select Level"
@onready var study: Control = $CanvasLayer/study
@onready var rich_text_label: RichTextLabel = $CanvasLayer/study/RichTextLabel

var directory = OS.get_executable_path().get_base_dir()
var save_game

# checks if the saved game has already been created if it has, player can continue
func _ready() -> void:
	study.hide()
	save_game = directory.path_join("save.txt")
	SongManager.sing_scene_song("titlescreen")
	
	if FileAccess.file_exists(save_game):
		pass
	else:
		load_game.disabled = true
		select_level.disabled = true

# when starting new game give participant surveys terrms
func _on_new_game_pressed() -> void:
	study.show()
	rich_text_label.text = "Please read through each item carefully, to indicate agreement press Accept, if there are any problems please press Decline:

- I confirm that I have read and understood the Participant Information Sheet for the above project and the researcher has answered any queries to my satisfaction.

- I understand that my participation is voluntary and that I am free to withdraw from the project at any time, up to the point of completion, without having to give a reason and without any consequences.

- I understand that anonymised data (i.e. data that do not identify me personally) cannot be withdrawn once they have been included in the study.

- I understand that any information recorded in the research will remain confidential and no information that identifies me will be made publicly available.

- I consent to being a participant in the project."

func _on_load_game_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/throne_room.tscn")
	
func _on_select_level_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/level_select.tscn")

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/settings.tscn")

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/credits.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

# player needs to accept the surveys terms to play the game
func _on_accept_pressed() -> void:
	SaveManager.create_save_file()
	get_tree().change_scene_to_file("res://levels/tutorial.tscn")

func _on_decline_pressed() -> void:
	study.hide()
