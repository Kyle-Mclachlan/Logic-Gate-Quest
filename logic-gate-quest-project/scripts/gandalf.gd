extends CharacterBody2D

const speed = 180
var follow = false
var player: CharacterBody2D = null
var time: float = 0.0

@onready var animate: AnimatedSprite2D = $AnimatedSprite2D
@onready var gandalf_walk: AudioStreamPlayer = $"gandalf walk"

# this constantly checks for if gandalf should be following the player, if he is then hiss position is moved closer and his animation is changed
func _physics_process(delta):
	if follow:
		time += delta
		var displacement = player.position - position
		position += (displacement * speed).normalized()
		# this checks to see which axis displacement is greater to prioritise animation
		if abs(displacement.x) > abs(displacement.y):
			if displacement.x > 0:
				_play_anim(true, "right")
			elif displacement.x < 0:
				_play_anim(true, "left")
		else:
			if displacement.y > 0:
				_play_anim(true, "down")
			elif displacement.y < 0:
				_play_anim(true, "up")
	else:
		_play_anim(false, "idle")

#plays the animation based on cats movement
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

# causes the cat to meow when catching up to the player after a long walk
func _sfx() -> void:
	if time > 5.0 and is_inside_tree():
		gandalf_walk.play()
		time = 0.0

# signals below

# when the player walks too far away from gandalf he will start to follow
func _on_area_2d_body_exited(body: Node2D) -> void:
	player = body
	follow = true

# when gandalf catches up to the player he will start his idle animation
func _on_area_2d_body_entered(body: Node2D) -> void:
	player = body
	follow = false
	call_deferred("_sfx")
