extends Node2D

# plays the music for the games levels
func _ready() -> void:
	SongManager.sing_scene_song("level")

# returns level number based off of the level name
func get_level() -> int:
	match name:
		"Level1": 
			return 1
		"Level2": 
			return 2
		"Level3": 
			return 3
		"Level4": 
			return 4
		"Level5": 
			return 5
		"Level6": 
			return 6
		"Level7": 
			return 7
		"Level8": 
			return 8
		"Level9": 
			return 9
		"Level10": 
			return 10
		"Level11": 
			return 11
		"Level12": 
			return 12
		"Level13": 
			return 13
		"Level14": 
			return 14
		"Level15": 
			return 15
		"Level16": 
			return 16
		"Level17": 
			return 17
		"Level18": 
			return 18
		"Level19": 
			return 19
		"Level20": 
			return 20
		"dragons_lair": 
			return 21
		_: 
			# unimportant levels return 0 as they aren't being saved
			return 0
