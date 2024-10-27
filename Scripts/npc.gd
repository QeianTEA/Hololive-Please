extends CharacterBody2D

var documents = []
@export var Document0: PackedScene
@export var Document1: PackedScene
@export var Document2: PackedScene
@onready var throw_out_documents = $"../ThrowOutDocuments"

@export var lines: Array[String] = []

var gameScript = Script

func _ready():
	documents.append(Document0)
	documents.append(Document1)
	documents.append(Document2)
	gameScript = get_parent().get_script()

func _physics_process(delta):
	pass

func ThrowOutDocuments():
	for n in documents.size():
		if documents[n] != null:
			Throw(documents[n])
		await wait_for_seconds(1.0)

func Throw(body):
	var instance = body.instantiate()
	add_sibling(instance)
	instance.position = throw_out_documents.position
	instance.playAnimation()

func wait_for_seconds(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
