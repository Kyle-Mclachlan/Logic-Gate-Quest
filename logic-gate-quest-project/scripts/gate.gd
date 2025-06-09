extends StaticBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D
@onready var gate_rattle: AudioStreamPlayer = $"gate rattle"

@onready var isOpen = false
@onready var startClosed = false
@onready var disrupted = false

# functionality for unlocking complex levels in throne room until basic levels have been completed
func _ready() -> void:
	if name == "throne_gate_1":
		animated_sprite_2d.play("hold open")
		isOpen = true
	elif name == "throne_gate_2":
		if SaveManager.get_level_data(12).get("complete", 0) == 1:
			animated_sprite_2d.play("hold open")
			isOpen = true

# function forr opening and closing the door based on input and disruption
func _switch(state: bool) -> void:
	if state and !isOpen and startClosed and !disrupted:
		animated_sprite_2d.play("open")
		isOpen = true
		gate_rattle.play()
	
	elif !state and isOpen and startClosed:
		animated_sprite_2d.play("close")
		isOpen = false
		gate_rattle.play()

# ensures no signals trigger the gate befor the player can ineteract with circuit
func _on_timer_timeout() -> void:
	startClosed = true

#when a player goes through an open gate save level as completed then change the scene
func _on_area_2d_body_entered(_body: Node) -> void:
	if isOpen:
		var interactions = _body._get_interactions()
		var time = _body._get_time()
		match name:
			"throne_gate_1":
				call_deferred("_travel_level_1")
			"lv1 gate":
				SaveManager.update_level_data(1,1,interactions,time)
				call_deferred("_travel_level_2")
			"lv2 gate":
				SaveManager.update_level_data(2,1,interactions,time)
				call_deferred("_travel_level_3")
			"lv3 gate":
				SaveManager.update_level_data(3,1,interactions,time)
				call_deferred("_travel_level_4")
			"lv4 gate":
				SaveManager.update_level_data(4,1,interactions,time)
				call_deferred("_travel_level_5")
			"lv5 gate":
				SaveManager.update_level_data(5,1,interactions,time)
				call_deferred("_travel_level_6")
			"lv6 gate":
				SaveManager.update_level_data(6,1,interactions,time)
				call_deferred("_travel_level_7")
			"lv7 gate":
				SaveManager.update_level_data(7,1,interactions,time)
				call_deferred("_travel_level_8")
			"lv8 gate":
				SaveManager.update_level_data(8,1,interactions,time)
				call_deferred("_travel_level_9")
			"lv9 gate":
				SaveManager.update_level_data(9,1,interactions,time)
				call_deferred("_travel_level_10")
			"lv10 gate":
				SaveManager.update_level_data(10,1,interactions,time)
				call_deferred("_travel_level_11")
			"lv11 gate":
				SaveManager.update_level_data(11,1,interactions,time)
				call_deferred("_travel_level_12")
			"lv12 gate":
				SaveManager.update_level_data(12,1,interactions,time)
				call_deferred("_travel_throne_room")
			"throne_gate_2":
				call_deferred("_travel_level_13")
			"lv13 gate":
				SaveManager.update_level_data(13,1,interactions,time)
				call_deferred("_travel_level_14")
			"lv14 gate":
				SaveManager.update_level_data(14,1,interactions,time)
				call_deferred("_travel_level_15")
			"lv15 gate":
				SaveManager.update_level_data(15,1,interactions,time)
				call_deferred("_travel_level_16")
			"lv16 gate":
				SaveManager.update_level_data(16,1,interactions,time)
				call_deferred("_travel_level_17")
			"lv17 gate":
				SaveManager.update_level_data(17,1,interactions,time)
				call_deferred("_travel_level_18")
			"lv18 gate":
				SaveManager.update_level_data(18,1,interactions,time)
				call_deferred("_travel_level_19")
			"lv19 gate":
				SaveManager.update_level_data(19,1,interactions,time)
				call_deferred("_travel_level_20")
			"lv20 gate":
				SaveManager.update_level_data(20,1,interactions,time)
				call_deferred("_travel_level_21")
			"lv21 gate":
				SaveManager.update_level_data(21,1,interactions,time)
				call_deferred("_travel_credits")

# gate movement

func _travel_throne_room() -> void:
	get_tree().change_scene_to_file("res://levels/throne_room.tscn")

func _travel_level_1() -> void:
	get_tree().change_scene_to_file("res://levels/level_1.tscn")

func _travel_level_2() -> void:
	get_tree().change_scene_to_file("res://levels/level_2.tscn")

func _travel_level_3() -> void:
	get_tree().change_scene_to_file("res://levels/level_3.tscn")

func _travel_level_4() -> void:
	get_tree().change_scene_to_file("res://levels/level_4.tscn")

func _travel_level_5() -> void:
	get_tree().change_scene_to_file("res://levels/level_5.tscn")

func _travel_level_6() -> void:
	get_tree().change_scene_to_file("res://levels/level_6.tscn")

func _travel_level_7() -> void:
	get_tree().change_scene_to_file("res://levels/level_7.tscn")

func _travel_level_8() -> void:
	get_tree().change_scene_to_file("res://levels/level_8.tscn")

func _travel_level_9() -> void:
	get_tree().change_scene_to_file("res://levels/level_9.tscn")

func _travel_level_10() -> void:
	get_tree().change_scene_to_file("res://levels/level_10.tscn")

func _travel_level_11() -> void:
	get_tree().change_scene_to_file("res://levels/level_11.tscn")

func _travel_level_12() -> void:
	get_tree().change_scene_to_file("res://levels/level_12.tscn")

func _travel_level_13() -> void:
	get_tree().change_scene_to_file("res://levels/level_13.tscn")

func _travel_level_14() -> void:
	get_tree().change_scene_to_file("res://levels/level_14.tscn")

func _travel_level_15() -> void:
	get_tree().change_scene_to_file("res://levels/level_15.tscn")

func _travel_level_16() -> void:
	get_tree().change_scene_to_file("res://levels/level_16.tscn")

func _travel_level_17() -> void:
	get_tree().change_scene_to_file("res://levels/level_17.tscn")

func _travel_level_18() -> void:
	get_tree().change_scene_to_file("res://levels/level_18.tscn")

func _travel_level_19() -> void:
	get_tree().change_scene_to_file("res://levels/level_19.tscn")
	
func _travel_level_20() -> void:
	get_tree().change_scene_to_file("res://levels/level_20.tscn")
	
func _travel_level_21() -> void:
	get_tree().change_scene_to_file("res://levels/level_21.tscn")

func _travel_credits() -> void:
	get_tree().change_scene_to_file("res://menus/credits.tscn")

# gate signal handling

func _change_gate_state(state: bool) -> void:
	_switch(state)

func _disrupt_gate(_state: bool) -> void:
	disrupted = true
	_switch(false)
