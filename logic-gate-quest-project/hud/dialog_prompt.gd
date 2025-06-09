extends Area2D

@onready var gandalf_meow: AudioStreamPlayer = $"gandalf meow"

signal dialog_message(message: String)

var message: String
var sent = false

# when player walks into a dialog it plays Gandalf's meow, gets relevanty message and returns it
func _on_body_entered(body: Node) -> void:
	if body is CharacterBody2D and sent == false:
		gandalf_meow.play()
		sent = true
		message = _get_message_by_name(name)
		emit_signal("dialog_message", message)

# match acts like a switch statement finding the message correlating to instance of dialog name
func _get_message_by_name(node_name: String) -> String:
	match node_name:
			"tutorial dialog":
				return "Hello brave knight, I am Gandalf your Feline Familiar.\n
We are on a quest to reclaim this castle from the sinister Dragon, we can beat him by using this castles magical Logic Gates.\n
To move use WASD or Arrow Keys, You can open the menu by pressing ESC this will allow you to restart the level, select a different level, alter your settings or return to the title screen, travel to the next level by walking through the open gate."
			"path dialog":
				return "Knight, this is the wrong way to the castle, let's go beat this Dragon."
			"throne dialog":
				# this lets the same dialog box give a different message depending on level progress
				if SaveManager.get_level_data(1).get("complete", 0) == 1:
					return "You can use Level Select in the Menu to replay completed levels or to continue where you left off. Lets continue on to beat this dragon"
				else:
					return "The left door leads to the basic levels which will help teach you logic gates, the right door leads to more complex levels which will test your skills, this only opens after completing the basic levels. "
			"lv1 dialog":
				return "The door to the next level is closed, to open it we will need to send it a powered charge from this simple circuit.\n
In the middle of the circuit there is an And Operator, this is represented as a 人 carved on a monolith. An And Gate requires both of it's inputs to be positive for it to send out a powered output, otherwise the gates output will be unpowered.\n
Try interacting with these levers, use E or Enter to flip them. "
			"lv2 dialog":
				return "On the left is an On Pylon, it constantly outputs a powered signal that cannot be changed.\n
Walk closer to the logic gate monolith in the center to see it's Truth Table appear in the bottom left of your screen."
			"lv2 dialog2":
				return "The leftmost columns represent each of the logic gates inputs, the numbers represent all possible combinations of powered and unpowered inputs where 1 represents powered and 0 represents unpowered.\n
The rightmost column of the truth table displays the logic gates output for its given inputs, as is shown in each row.\
The outputs will be different depending on the type of logic gate."
			"lv3 dialog":
				return "The monolith to the right of the circuit can be picked up, it can be dropped anywhere on screen but if it's dropped near enough to a slot in a circuit it will function as a monolith of the same logic type.\n
These stones can be moved with E or Enter and can still be picked up after being placed in a slot. All stones with green outlines can be moved."
			"lv4 dialog":
				return "Multiple Operators can be Used in a circuit, these bottom Operators feed into the top one the same way the levers feed into them."
			"lv5 dialog":
				return "In the middle of this circuit there is an Or Operator, this is represented as a V carved on the monolith.\n
An Or Gate has a powered output if just one of its inputs is powered, it still works with two powed inputs but not two unpowered inputs.\n
There is also an off pylon on the left which produces a constant unpowered output."
			"lv9 dialog":
				return "In the middle of this circuit there is a Not Operator, this is represented as a ¬ carved on the monolith.\n
A Not Operator Inverts whatever its input is for its output, turning a power input into an unpowered output and an unpowered input into a powered output."
			"lv12 dialog":
				return "This is the last basic level, once you’ve completed it you will be brought back to the Throne Room where the gate on the right will now be open."
			"lv13 dialog":
				return "In the middle of this circuit there is a Xor Operator, this is represented as a ⨁ carved on the monolith.\n
A Xor Operator is also known as exclusive Or, as it only produces a positive output if only one of its inputs is positive, otherwise its output is unpowered."
			"lv15 dialog":
				return "This level has an example of how Xor can be made using other Logic Gates, most operators can be made from a combination of others."
			"disruptor intro":
				return "This a disruptor, it disrupts the gate mechanism and forces it shut regardless of if the door being powered.\n
Once powered the disruptor cannot be turned off, the level needs to be restarted to complete."
			_:
				return "error this shouldnt be seen"
