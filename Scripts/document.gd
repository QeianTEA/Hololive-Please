extends CharacterBody2D

var draggingDistance
var dir
var dragging = false
var newPosition = Vector2()

@export var bigTextureScale = 1.0
@export var bigTexture = Texture2D
@export var smallTexture = Texture2D

@onready var sprite_2d = $Sprite2D
@onready var small_collider = $SmallCollider

var mouse_in = false
var chossen = false
var big = false


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
			
	elif event is InputEventMouseMotion:
		if dragging:
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir

func _physics_process(delta):
	if dragging:
		velocity = (newPosition - position) * Vector2(50, 50)
		move_and_slide()

func chosen():
	chossen = true

func sizechange(big):
	if big:
		scale = Vector2(bigTextureScale, bigTextureScale)
		sprite_2d.texture = bigTexture
	else:
		scale = Vector2(1,1)
		sprite_2d.texture = smallTexture

func _on_mouse_entered():
	mouse_in = true

func _on_mouse_exited():
	mouse_in = false
