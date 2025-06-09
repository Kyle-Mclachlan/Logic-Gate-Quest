extends Node

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

const titlescreen_song = preload("res://music/06 Visager - Overgrown Labyrinth [Loop].mp3")
const settings_song = preload("res://music/02 Visager - Shoots [Loop].mp3")
const credits_song = preload("res://music/01 Visager - The Great Tree [Loop].mp3")
const levels_song = preload("res://music/Nutmeg - Hey Nonny Yes.mp3")

var current_song: AudioStream = null
var music_bus = AudioServer.get_bus_index("music")

func _ready() -> void:
	set_volume(PersistantSettings.get_music_volume())

# when setting music volume use linear scale for better adjustment accuracy
func set_volume(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value / 100.0))

# when level calls for a song to be played check if its the same song type currently being played
func sing_scene_song(scene: String) -> void:
	var song = _select_song(scene)
	audio_stream_player.bus = "music" 
	if song == null:
		_play_music(current_song)
	else:
		_play_music(song)

# get song for level type
func _select_song(current_scene: String) -> AudioStream:
	match current_scene:
		"titlescreen":
			return titlescreen_song
		"settings":
			return settings_song
		"level":
			return levels_song
		"credits":
			return credits_song
		_:
			return null

# give the song to the music player node to be played
func _play_music(song: AudioStream) -> void:
	if audio_stream_player.stream != song:
		current_song = song
		audio_stream_player.stream = song
		audio_stream_player.play()

# when a song finishes play it again to loop
func _on_audio_stream_player_finished() -> void:
	audio_stream_player.play()
