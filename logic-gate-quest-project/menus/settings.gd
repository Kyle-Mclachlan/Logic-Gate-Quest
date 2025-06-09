extends Control

@onready var fullscreen_toggle: CheckButton = $VBoxContainer/fullscreen_toggle
@onready var music_slider: HSlider = $"VBoxContainer/music slider"
@onready var sfx_slider: HSlider = $"VBoxContainer/sfx slider"
@onready var truth_table_toggle: CheckButton = $VBoxContainer/truth_table_toggle
@onready var annotation_toggle: CheckButton = $VBoxContainer/annotation_toggle
@onready var level_select: Button = $"level select"

var directory = OS.get_executable_path().get_base_dir()
var save_game

func _ready() -> void:
	# play settings music
	SongManager.sing_scene_song("settings")
	
	# check if there is a save to allow access to level select
	save_game = directory.path_join("save.txt")
	if FileAccess.file_exists(save_game):
		pass
	else:
		level_select.disabled = true
	
	# when settings page opened set buttons to what the persistant settings are
	fullscreen_toggle.button_pressed = PersistantSettings.get_fullscreen()
	music_slider.value = PersistantSettings.get_music_volume()
	sfx_slider.value = PersistantSettings.get_sfx_volume()
	truth_table_toggle.button_pressed = PersistantSettings.get_truth_table()
	annotation_toggle.button_pressed = PersistantSettings.get_circuit_annotation()

# button handling

func _on_title_screen_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/title_screen.tscn")

func _on_level_select_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/level_select.tscn")

func _on_fullscreen_toggle_toggled(toggle: bool) -> void:
	if toggle:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	PersistantSettings.set_fullscreen(toggle)

func _on_music_slider_value_changed(value: float) -> void:
	PersistantSettings.set_music_volume(value)

func _on_sfx_slider_value_changed(value: float) -> void:
	PersistantSettings.set_sfx_volume(value)

func _on_truth_table_toggle_toggled(toggle: bool) -> void:
	PersistantSettings.set_truth_table(toggle)

func _on_annotation_toggle_toggled(toggle: bool) -> void:
	PersistantSettings.set_circuit_annotation(toggle)
