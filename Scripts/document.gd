extends CharacterBody2D

var draggingDistance
var dir
var dragging = false
var newPosition = Vector2()

@export var bigTextureScale = 1.0
@export var bigTexture = Texture2D
@export var smallTexture = Texture2D


@export var canBeStamped = true
@onready var clipper = $Clipper
@onready var sprite_2d = $Clipper/MainImages
@onready var small_collider = $SmallCollider

@export var giveText: Label
@export var labels = Node2D

@export var gift = false
var mouse_in = false
var chossen = false
var big: bool
var givable: bool


func _input(event):
	if event is InputEventMouseButton:
		if chossen && event.is_pressed() && mouse_in:
			draggingDistance = position.distance_to(get_viewport().get_mouse_position())
			dir = (get_viewport().get_mouse_position() - position).normalized()
			dragging = true
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir
		else:
			dragging = false
			chossen = false
			
		if event.is_released() && givable:
			giveDocument()
			
	elif event is InputEventMouseMotion:
		if dragging:
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir

var readyToGo = false

func _ready():
	readyToGo = true

func _physics_process(delta):
	if not is_node_ready():
		return
		
	if dragging:
		velocity = (newPosition - position) * Vector2(50, 50)
		move_and_slide()
		
	if givable:
		giveText.visible = true
	else:
		giveText.visible = false


func giveDocument():
	var gameScript = get_parent()
	gameScript.documentsToBeGiven -= 1
	queue_free()

func chosen():
	chossen = true

func sizechange(big):
	if big:
		scale = Vector2(bigTextureScale, bigTextureScale)
		hideAllSprites(false)
		sprite_2d.texture = bigTexture
	else:
		scale = Vector2(1,1)
		hideAllSprites(true)
		sprite_2d.texture = smallTexture
		


func hideAllSprites(yes):
	if yes:
		for child in clipper.get_children():
			if (child is Sprite2D and child != sprite_2d):  # Check if the child node is of type Sprite
				child.visible = false  # Set the visibility to false
		labels.visible = false
	else:
		for child in clipper.get_children():
			if child is Sprite2D:  # Check if the child node is of type Sprite
				child.visible = true  # Set the visibility to false
		labels.visible = true

func playAnimation():
	var randomNum = randi_range(-10,10)
	move_down(40 + randomNum, 0.5)  # Move 20 pixels down over 0.5 seconds

func move_down(pixels: int, duration: float):
	var tween = create_tween()
	# Set start and end positions
	var start_position = position
	var end_position = start_position + Vector2(0, pixels)
	
	# Start the tween
	tween.tween_property(self, "position", end_position, duration)

	# Await the completion
	await tween.finished

func _on_mouse_entered():
	mouse_in = true

func _on_mouse_exited():
	mouse_in = false
