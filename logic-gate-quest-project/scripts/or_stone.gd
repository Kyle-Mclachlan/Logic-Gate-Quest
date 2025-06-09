extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var label: Label = $Label
@onready var up: AudioStreamPlayer = $up
@onready var down: AudioStreamPlayer = $down

var current_slot: Node2D = null

const speed = 150
var following = false
var player: CharacterBody2D = null
var velocity = Vector2.ZERO

func _ready() -> void:
	if !PersistantSettings.get_circuit_annotation():
		label.hide()

func get_type():
	return "or"

# make the stone node follow the player if it has been picked up
func _process(delta):
	if following:
		var player_at = player.global_position + Vector2(0,0)
		var displacement = player_at - global_position
		velocity = displacement.normalized() * speed
		position += velocity * delta

# when stone is picked up play sfx and tun the node invisible as player has carry animation
func _pick_up(player_ref: CharacterBody2D) -> void:
	up.play()
	if current_slot:
		current_slot.clear_stone()
		current_slot = null
	player = player_ref
	following = true
	visible = false
	collision_layer = 0
	collision_mask = 0

# when stone is dropped play sfx then place and show the node
func _drop_off(drop_position: Vector2) -> void:
	down.play()
	current_slot = _near_slot_check()
	following = false
	if current_slot:
		global_position = current_slot.global_position
		current_slot.get_stone_type(self)
		visible = false
	else:
		global_position = drop_position
		visible = true
	collision_layer = 1
	collision_mask = 1

# when stone put down checks if it is within range of any slots 
func _near_slot_check():
	var found_slots = get_tree().get_nodes_in_group("slot")
	for slot in found_slots:
		var distance = global_position.distance_to(slot.global_position)
		if distance < 25:
			return slot
	return null
