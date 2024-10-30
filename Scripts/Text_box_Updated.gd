extends Control

# Number of maximum lines on screen
const MAX_LINES = 3

# Reference to VBoxContainer that will hold message lines
@onready var VboxContainer = $VBoxContainer
@onready var background_texture = preload("res://Fonts/text box.png")
@onready var text_box = preload("res://Scenes/text_box.tscn")

# Initialize conversation lines
var tempConvo = []

var current_line_index = 0

func start_conversation(conversation):
	current_line_index = 0
	# Start the first line by the player
	
	tempConvo = conversation
	add_message(tempConvo[current_line_index]["speaker"], tempConvo[current_line_index]["text"])
	current_line_index += 1
	# Start timer for NPC responses
	$MessageTimer.start()
	

func add_message(speaker: String, text: String):
	
	var box = text_box.instantiate()
	
	if speaker == "Player":
		box.allignment = false
		box.textLabel = text
	else:
		box.allignment = true
		box.textLabel = text

	VboxContainer.add_child(box)
	
	# Limit messages to MAX_LINES
	if VboxContainer.get_child_count() > MAX_LINES:
		VboxContainer.get_child(0).queue_free()  # Remove the oldest line
	
func _on_MessageTimer_timeout():
	# Automatically add the next line from the conversation
	if current_line_index < tempConvo.size():
		add_message(tempConvo[current_line_index]["speaker"], tempConvo[current_line_index]["text"])
		current_line_index += 1
	else:
		$MessageTimer.stop()  # Stop timer if conversation ends
		tempConvo = null
		_KillMessage()

func _KillMessage():
	if tempConvo == null:
		for i in VboxContainer.get_child_count():
			await get_tree().create_timer(3).timeout
			if VboxContainer.get_children() != null and tempConvo == null:
				if VboxContainer.get_child(0) != null:
					VboxContainer.get_child(0).queue_free()
			else:
				return
	else:
		return

