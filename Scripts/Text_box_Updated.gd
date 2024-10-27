extends Control

# Number of maximum lines on screen
const MAX_LINES = 4

# Reference to VBoxContainer that will hold message lines
@onready var VboxContainer = $VBoxContainer
@onready var background_texture = preload("res://Fonts/text box.png")
@onready var text_box = preload("res://Scenes/text_box.tscn")

# Initialize conversation lines
var conversation = [
	{"speaker": "Player", "text": "tickets please."},
	{"speaker": "NPC", "text": "Hello! Here's my ticket."},
	{"speaker": "NPC", "text": "Nice weather today, isn’t it?"},
	{"speaker": "NPC", "text": "I hope the ride will be smooth."},
	{"speaker": "Player", "text": "cause no trouble."}
]

var current_line_index = 0

func _ready():
	start_conversation()

func start_conversation():
	# Start the first line by the player
	add_message(conversation[current_line_index]["speaker"], conversation[current_line_index]["text"])
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
	if current_line_index < conversation.size():
		add_message(conversation[current_line_index]["speaker"], conversation[current_line_index]["text"])
		current_line_index += 1
	else:
		$MessageTimer.stop()  # Stop timer if conversation ends
