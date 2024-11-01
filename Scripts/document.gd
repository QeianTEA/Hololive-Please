extends CharacterBody2D

var draggingDistance
var dir
var dragging: bool :set = setDragging
var newPosition = Vector2()

@export var bigTextureScale = 1.0
@export var bigTexture = Texture2D
@export var smallTexture = Texture2D

@export var canBeStamped = true
@onready var clipper = $Clipper
@onready var sprite_2d = $Clipper/MainImages
@onready var small_collider = $SmallCollider

@onready var control = $Clipper/Node2D
@onready var give_text = $GiveText

@export var id : bool
@export var ticket: bool
@export var gift = false
var mouse_in = false
var chossen = false
var big: bool
var givable: bool

@export var faulty: bool
@export var special: bool

var gameScript


func _ready():
	await GlobalDocumentRandomizer.readyToRoll
	gameScript = get_parent()
	dragging = false
	
	if !special:
		$Clipper/Node2D/NameLalble.text = GlobalDocumentRandomizer.npcName
		if id:
			$Clipper/Node2D/Dob.text = GlobalDocumentRandomizer.npcDob
			$Clipper/Node2D/From.text = GlobalDocumentRandomizer.place
			$Clipper/Node2D/DateLable.text = GlobalDocumentRandomizer.expiryDate
			$Clipper/Node2D/Ranodm.text = GlobalDocumentRandomizer.barcode
		if ticket:
			$Clipper/Node2D/DateLable.text = GlobalDocumentRandomizer.RandomizeThis("date")

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

func _physics_process(delta):
	
	if gameScript.inspectMode:
		if ticket:
			$Clipper/Node2D/DateLable/Date.disabled = false
			$Clipper/Node2D/NameLalble/Name.disabled = false
		
		if id:
			$Clipper/Node2D/NameLalble/Name.disabled = false
			$Clipper/Node2D/Dob/dob.disabled = false
			$Clipper/Node2D/From/from.disabled = false
			$Clipper/Node2D/DateLable/Date.disabled = false
			$Clipper/Node2D/Ranodm/random.disabled = false
	else :
		if ticket:
			$Clipper/Node2D/DateLable/Date.disabled = true
			$Clipper/Node2D/NameLalble/Name.disabled = true
		
		if id:
			$Clipper/Node2D/NameLalble/Name.disabled = true
			$Clipper/Node2D/Dob/dob.disabled = true
			$Clipper/Node2D/From/from.disabled = true
			$Clipper/Node2D/DateLable/Date.disabled = true
			$Clipper/Node2D/Ranodm/random.disabled = true
	
	if dragging:
		velocity = (newPosition - position) * Vector2(50, 50)
		move_and_slide()
		
	if givable:
		give_text.visible = true
	else:
		give_text.visible = false


func setDragging(v : bool):
	if dragging == v:
		return
	dragging = v
	if v:
		$Start.play()
	else:
		$end.play()
	

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
		control.visible = true
	else:
		scale = Vector2(1,1)
		hideAllSprites(true)
		sprite_2d.texture = smallTexture
		control.visible = false


func hideAllSprites(yes):
	if yes:
		for child in clipper.get_children():
			if (child is Sprite2D and child != sprite_2d):  # Check if the child node is of type Sprite
				child.visible = false  # Set the visibility to false

	else:
		for child in clipper.get_children():
			if child is Sprite2D:  # Check if the child node is of type Sprite
				child.visible = true  # Set the visibility to false


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
