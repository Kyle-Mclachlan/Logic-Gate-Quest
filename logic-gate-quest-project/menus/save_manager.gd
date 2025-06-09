extends Node

var directory = OS.get_executable_path().get_base_dir()
var save_file

var progress: Array = []

# Script is persistant, when game starts it tries to load in saved data
func _ready() -> void:
	save_file = directory.path_join("save.txt")
	_load_game_data()

# if data found participant acceptance line is ignored and all level data is added to progress array
func _load_game_data() -> void:
	if FileAccess.file_exists(save_file):
		var file = FileAccess.open(save_file, FileAccess.READ)
		if file:
			file.get_line()
			progress.clear()
			while not file.eof_reached():
				var line = file.get_line().strip_edges()
				if line:
					progress.append(line)
			file.close()

# when starting a new game, a save file needs to be created, it is populated with empty level data
func create_save_file() -> void:
	var file = FileAccess.open(save_file, FileAccess.WRITE)
	if file:
		file.store_line("The Participant agrees to have their data recorded")
		for i in range(21):
			file.store_line("%d 0 0 0" % [i + 1])
		file.close()
	_load_game_data()

# returns a dictionary of specified level from the progress array, after checking level is valid
func get_level_data(level: int) -> Dictionary:
	if level < 1 or level > 21:
		return {}

	var part = progress[level - 1].split(" ")
	return {
		"level": int(part[0]),
		"complete": int(part[1]),
		"interactions": int(part[2]),
		"time": float(part[3])}

# when player completes or leaves level update arrrray with collected level details
func update_level_data(level: int, completed: int, interactions: int, time: float) -> void:
	var saved_data = get_level_data(level)
	var saved_completion = saved_data.get("complete", 0)
	var saved_interactions = saved_data.get("interactions", 0)
	var saved_time = saved_data.get("time", 0)
	
	# check to ensure that completed levels values arent changed
	if saved_completion == 0:
		var new_interactions = saved_interactions + interactions
		var new_time = saved_time + time
		progress[level - 1] = "%d %d %d %.2f" % [level, completed, new_interactions, new_time]
		_save_to_file()

# this helper function populates the save file with current player progress, after a levels data has been updated
func _save_to_file() -> void:
	var file = FileAccess.open(save_file, FileAccess.WRITE)
	if file:
		file.store_line("The Participant agrees to have their data recorded")
		for line in progress:
			file.store_line(line)
		file.close()
