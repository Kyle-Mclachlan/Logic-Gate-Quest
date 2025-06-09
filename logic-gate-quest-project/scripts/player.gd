extends CharacterBody2D

@onready var animate: AnimatedSprite2D = $AnimatedSprite2D
@onready var dialog: Control = $CanvasLayer/dialog
@onready var dialog_label: RichTextLabel = $CanvasLayer/dialog/RichTextLabel
@onready var menu: Control = $CanvasLayer/menu
@onready var interaction_handler: Node2D = $InteractionHandler
@onready var retry_disruption: Button = $"CanvasLayer/dialog/retry disruption"

const speed = 140
var current_dir = "none"
var lifting_stone = false
var stone_type = ""
var current_level
var menu_open = false
var dialog_open = false
var level_time = 0.00

func _ready() -> void:
	menu.hide()
	dialog.hide()
	retry_disruption.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	current_level = get_parent().get_parent().get_level()

# display the dialog when a player walks into a dialog trigger
func _show_dialog(message: String) -> void:
	dialog_label.text = message
	dialog.show()
	dialog_open = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# special dialog for when the player disrupts the circuit
func _show_disrupt_dialog() -> void:
	dialog_label.text = "This level can't be completed, please press                         to attempt this level again\n
You may continue to look throught this level. when you are ready to rety this can be accessed by accessed through the menu with ESC"
	dialog.show()
	retry_disruption.show()
	dialog_open = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# function  for players button presses , dealing with menus and movement
func _physics_process(delta):
	var velocity_x = 0
	var velocity_y = 0
	
	if not menu_open:
		#keep track of the players level time
		level_time = level_time + delta
	
	# player can toggle the menu
	if Input.is_action_just_pressed("menu"):
		if menu_open == false:
			menu.show()
			menu_open = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		elif menu_open == true:
			menu.hide()
			menu_open = false
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	# player closing the dialog
	if Input.is_action_just_pressed("end_dialog"):
		if dialog_open == true:
			dialog.hide()
			retry_disruption.hide()
			dialog_open = false
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	# when the menu or dialog box are open stop the player from walking around
	if menu_open == false  and dialog_open == false:
		# handling for player movement and directional animations
		if Input.is_action_pressed("right") and Input.is_action_pressed("left"):
			velocity_x = 0
		
		elif Input.is_action_pressed("right"):
			velocity_x = speed
			current_dir = "right"
		
		elif Input.is_action_pressed("left"):
			velocity_x = -speed
			current_dir = "left"
		
		if Input.is_action_pressed("up") and Input.is_action_pressed("down"):
			velocity_y = 0
		
		elif Input.is_action_pressed("up"):
			velocity_y = -speed
			current_dir = "up"
		
		elif Input.is_action_pressed("down"):
			velocity_y = speed
			current_dir = "down"
	
	
	# using a vector for player movemen tto allow for better movement, can move across diagonals
	var normal_velocity = Vector2(velocity_x, velocity_y)
	
	if normal_velocity.length() > 0:
		normal_velocity = normal_velocity.normalized() * speed
	
	velocity = normal_velocity
	
	# check for if the player is carrying a stone, to ensure animation is correct
	match stone_type:
		"":
			_play_anim(velocity.length() > 0, current_dir)
		"and":
			_play_anim_and(velocity.length() > 0, current_dir)
		"or":
			_play_anim_or(velocity.length() > 0, current_dir)
		"xor":
			_play_anim_xor(velocity.length() > 0, current_dir)
	
	# moves the player body based on the calculated velocity
	move_and_slide()

#player animation based on direction and carried stone

func _play_anim(movement, dir):
	if movement:
		match dir:
			"down":
				animate.play("down")
			"up":
				animate.play("up")
			"left":
				animate.play("left")
			"right":
				animate.play("right")
	else:
		animate.play("idle")

func _play_anim_and(movement, dir):
	if movement:
		match dir:
			"down":
				animate.play("and down")
			"up":
				animate.play("and up")
			"left":
				animate.play("and left")
			"right":
				animate.play("and right")
	else:
		animate.play("and idle")

func _play_anim_or(movement, dir):
	if movement:
		match dir:
			"down":
				animate.play("or down")
			"up":
				animate.play("or up")
			"left":
				animate.play("or left")
			"right":
				animate.play("or right")
	else:
		animate.play("or idle")

func _play_anim_xor(movement, dir):
	if movement:
		match dir:
			"down":
				animate.play("xor down")
			"up":
				animate.play("xor up")
			"left":
				animate.play("xor left")
			"right":
				animate.play("xor right")
	else:
		animate.play("xor idle")

#this allow sthe player update visuals and stone functionality based off the stone being interacted with
func move_stone(stone: Node2D) -> void:
	if lifting_stone:
		stone._drop_off(global_position)
		lifting_stone = false
		stone_type = ""
	else:
		stone._pick_up(self)
		lifting_stone = true
		stone_type = stone.get_type()

# scene changes and getters for saving

func _title_scene():
	get_tree().change_scene_to_file("res://menus/title_screen.tscn")

func _select_level():
	get_tree().change_scene_to_file("res://menus/level_select.tscn")

func _settings():
	get_tree().change_scene_to_file("res://menus/settings.tscn")

func _throne_room():
	get_tree().change_scene_to_file("res://levels/throne_room.tscn")

func _get_interactions() -> int:
	return interaction_handler._get_interactions()

func _get_time() -> float:
	return level_time

# signal handeling

func _on_resume_pressed() -> void:
	menu.hide()
	menu_open = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_retry_pressed() -> void:
	if current_level > 0:
		SaveManager.update_level_data(current_level, 0, _get_interactions(), level_time)
	get_tree().reload_current_scene()

func _on_level_select_pressed() -> void:
	if current_level > 0:
		SaveManager.update_level_data(current_level, 0, _get_interactions(), level_time)
	call_deferred("_select_level")

func _on_settings_pressed() -> void:
	if current_level > 0:
		SaveManager.update_level_data(current_level, 0, _get_interactions(), level_time)
	call_deferred("_settings")

func _on_throne_room_pressed() -> void:
	if current_level > 0:
		SaveManager.update_level_data(current_level, 0, _get_interactions(), level_time)
	call_deferred("_throne_room")

func _on_title_screen_pressed() -> void:
	if current_level > 0:
		SaveManager.update_level_data(current_level, 0, _get_interactions(), level_time)
	call_deferred("_title_scene")

func _on_disruptor_activated(state: bool) -> void:
	if state:
		_show_disrupt_dialog()
