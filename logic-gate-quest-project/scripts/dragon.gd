extends StaticBody2D

@onready var dragon: StaticBody2D = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var dialog: Control = $CanvasLayer/dialog
@onready var catapult: AudioStreamPlayer = $catapult

var powered = false
var disrupted = false
var fired = false
var dialog_open = false
var player

func _ready() -> void:
	dialog.hide()

#check for input and disruption before launching catapult and starting end of game
func on_interact():
	if powered and not disrupted:
		fired = true
		animated_sprite_2d.play("dragon fire")
		catapult.play()
		await get_tree().create_timer(1.0).timeout
		dialog.show()
		dialog_open = true

# when player closes final dialog save game and go to credits
func _process(_delta: float) -> void:
	if dialog_open and Input.is_action_just_pressed("end_dialog"):
		dialog.hide()
		var interactions = player._get_interactions()
		var time = player._get_time()
		SaveManager.update_level_data(21,1,interactions,time)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		call_deferred("_travel_credits")

func _travel_credits() -> void:
	get_tree().change_scene_to_file("res://menus/credits.tscn")

func get_fired() -> bool:
	return fired

func _switch(state: bool) -> void:
	powered = state
	if state:
		animated_sprite_2d.play("dragon powered")
	else:
		animated_sprite_2d.play("dragon rest")

func _change_state(state: bool) -> void:
	_switch(state)

func _disrupt_dragon(_state: bool) -> void:
	disrupted = true

#getting a refernece to the player to allow for saving the level  data
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player": 
		player = body
