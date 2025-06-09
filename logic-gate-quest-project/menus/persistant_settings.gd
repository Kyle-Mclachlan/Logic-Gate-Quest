extends Node

# persistant variables to store the games settings
var fullscreen = true
var music_volume = 20
var sfx_volume = 30
var truth_table = true
var circuit_annotation = true

# getters and setters for the persistant settings

func set_fullscreen(value: bool) -> void:
	fullscreen = value
	
func get_fullscreen() -> bool:
	return fullscreen

func set_music_volume(value: float) -> void:
	music_volume = value
	SongManager.set_volume(value)

func get_music_volume() -> float:
	return music_volume

func set_sfx_volume(value: float) -> void:
	sfx_volume = value
	# when adjusting the audio volume used linear scale otherwise volume only really changes in bottom third of bar
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"), linear_to_db(value / 100.0))

func get_sfx_volume() -> float:
	return sfx_volume

func set_truth_table(value: bool) -> void:
	truth_table = value

func get_truth_table() -> bool:
	return truth_table

func set_circuit_annotation(value: bool) -> void:
	circuit_annotation = value

func get_circuit_annotation() -> bool:
	return circuit_annotation
