extends Node2D

@onready var label: Label = $label
@onready var and_tt: Sprite2D = $"truth table/AndTt"
@onready var or_tt: Sprite2D = $"truth table/OrTt"
@onready var not_tt: Sprite2D = $"truth table/NotTt"
@onready var xor_tt: Sprite2D = $"truth table/XorTt"
@onready var player = get_parent()

var interactables = []
var available = true
var lifting = false
var interact_count = 0

func _ready() -> void:
	label.hide()
	_hide_truth_table()

# this function allows for the player to interact with objects that have a suitable group type
func _input(event: InputEvent) -> void:
	# check to  ensure that the player is only within range of one interactable object and cooldown is over, when interacting
	if event.is_action_pressed("interact") and available and interactables.size() == 1:
		var object = interactables[0]
		available = false
		# increase the total level intetactions
		interact_count = interact_count + 1
		label.hide()
		
		# checking for what group type the interactable is make interaction call
		if object.get_groups().has("lever"):
			object.get_parent().on_interact()
		elif object.get_groups().has("stone"):
			var stone = object.get_parent()
			player.move_stone(stone)
			if lifting:
				lifting = false
			else:
				lifting = true
		# catapult can only be fired once
		elif object.get_groups().has("dragon"):
			if not object.get_parent().get_fired():
				object.get_parent().on_interact()
		# this allows for a cooldown in player interaction
		await get_tree().create_timer(1.0).timeout
		available = true

# this acts as a display function for dealing with what is displayed to the player on screen depending on the objects group type
func _process(_delta: float) -> void:
	if interactables and available and interactables.size() == 1:
		var object = interactables[0]
		
		if object.get_groups().has("lever"):
			label.text = "Flip Switch"
			label.show()
		elif object.get_groups().has("stone"):
			# movable logic gate message changes on if its currently carried
			if lifting:
				label.text = "Place Stone"
			else:
				label.text = "Pick Up Stone"
			label.show()
			_show_truth_table(object)
		elif object.get_groups().has("monolith"):
				_show_truth_table(object)
		elif object.get_groups().has("dragon"):
			# small check as catapult can only be fired once, stop displaying message after
			if not object.get_parent().get_fired():
				label.text = "Catapult Dragon"
				label.show()
		# hide message and truth tables when no longer near object
		else:
			label.hide()
			if not lifting:
				_hide_truth_table()
	else:
		label.hide()
		if not lifting:
			_hide_truth_table()

# show relevent truth table while in vacinity on logic gate
func _show_truth_table(object):
	if PersistantSettings.get_truth_table():
		if object.get_groups().has("and TT"):
			and_tt.show()
		elif object.get_groups().has("or TT"):
			or_tt.show()
		elif object.get_groups().has("not TT"):
			not_tt.show()
		elif object.get_groups().has("xor TT"):
			xor_tt.show()

func _hide_truth_table():
	and_tt.hide()
	or_tt.hide()
	not_tt.hide()
	xor_tt.hide()

# function to access interactions for saving game
func _get_interactions() -> int:
	return interact_count

# signals below for settign array to nearby interacable objects
func _on_interact_range_area_entered(area: Area2D) -> void:
	interactables.append(area)

func _on_interact_range_area_exited(area: Area2D) -> void:
	interactables.erase(area)
