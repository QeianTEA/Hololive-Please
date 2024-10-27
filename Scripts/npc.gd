extends CharacterBody2D

var documents = []
@export var Document0: PackedScene
@export var Document1: PackedScene
@export var Document2: PackedScene
@onready var throw_out_documents = $"../ThrowOutDocuments"

@export var lines: Array[String] = []

var gameScript = Script
var conversation = [
	{"speaker": "Player", "text": "tickets please."},
	{"speaker": "NPC", "text": "Hello! Here's my ticket."},
	{"speaker": "NPC", "text": "Nice weather today, isn’t it?"},
	{"speaker": "NPC", "text": "I hope the ride will be smooth."}
	]

var approved: bool
var canGo: bool

func _ready():
	documents.append(Document0)
	documents.append(Document1)
	documents.append(Document2)
	gameScript = get_parent()

func _physics_process(delta):
	if canGo:
		if approved:
			pass

func ThrowOutDocuments():
	gameScript.startConvo(conversation)
	
	for n in documents.size():
		if documents[n] != null:
			Throw(documents[n])
		await wait_for_seconds(1.0)

func Throw(body):
	var instance = body.instantiate()
	add_sibling(instance)
	instance.position = throw_out_documents.position
	instance.playAnimation()
	gameScript.documentsToBeGiven += 1

func wait_for_seconds(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
