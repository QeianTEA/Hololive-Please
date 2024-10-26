extends Control

# Number of maximum lines on screen
const MAX_LINES = 4

# Reference to VBoxContainer that will hold message lines
@onready var message_container = $VBoxContainer
@onready var background_texture = preload("res://Fonts/text box.png")

# Initialize conversation lines
var conversation = [
	{"speaker": "Player", "text": "tickets please"},
	{"speaker": "NPC", "text": "Hello! Here's my ticket."},
	{"speaker": "NPC", "text": "Nice weather today, isn’t it?"},
	{"speaker": "NPC", "text": "I hope the ride will be smooth."},
	{"speaker": "Player", "text": "cause no trouble"}
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
	 # Create a new HBoxContainer for each message line
	var message_line = HBoxContainer.new()
	message_line.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	
	var bg = NinePatchRect.new()
	bg.texture = background_texture
	bg.set_size(Vector2(200, 50))  # Example size, can be dynamically set based on text size
	
	var player_label = Label.new()
	player_label.text = text if speaker == "Player" else ""
	bg.add_child(player_label)  # Attach player label to player NinePatchRect
	
	bg.texture = background_texture
	bg.set_size(Vector2(200, 50))
	
	var npc_label = Label.new()
	npc_label.text = text if speaker == "NPC" else ""
	bg.add_child(npc_label)  # Attach NPC label to NPC NinePatchRect

	# Add NinePatchRects to HBoxContainer based on the speaker
	if speaker == "Player":
		message_line.add_child(bg)
		message_line.add_spacer(false)
	else:
		message_line.add_spacer(true)
		message_line.add_child(bg)
	
	
	# Add the line to the main container
	message_container.add_child(message_line)
	
	# Limit messages to MAX_LINES
	if message_container.get_child_count() > MAX_LINES:
		message_container.get_child(0).queue_free()  # Remove the oldest line
	
func _on_MessageTimer_timeout():
	# Automatically add the next line from the conversation
	if current_line_index < conversation.size():
		add_message(conversation[current_line_index]["speaker"], conversation[current_line_index]["text"])
		current_line_index += 1
	else:
		$MessageTimer.stop()  # Stop timer if conversation ends
