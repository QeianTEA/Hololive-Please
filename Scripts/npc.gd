extends CharacterBody2D

var documents = []
@export var specialGuest: bool
@export var Document0: PackedScene
@export var Document1: PackedScene
@export var Document2: PackedScene
@onready var throw_out_documents = $"../ThrowOutDocuments"

@onready var come = $Come

var goingBack = false
var can_be_deleted: bool


var gameScript = Script
@export var conversation = [
	{"speaker": "Player", "text": "Your ticket."},
	{"speaker": "NPC", "text": "Hello! Here's my ticket."}
	]

@export var convoApproved = [
	{"speaker": "Player", "text": "Don't cause trouble."},
	{"speaker": "NPC", "text": "Yeeeeaaa!!"}
	]

@export var convoDenied = [
	{"speaker": "NPC", "text": "Huh? No..."},
	{"speaker": "NPC", "text": "Stupid Scammers"}
	]

func _ready():
	documents.append(Document0)
	documents.append(Document1)
	documents.append(Document2)
	gameScript = get_parent()
		
	

func _physics_process(delta):
	if gameScript.documentsToBeGiven < 1 && gameScript.stamped:
		if gameScript.approved:
			gameScript.startConvo(convoApproved)
			goingBack = true
			come.play_backwards("GoRight")
			gameScript.NPCapprovedornah(true)
		else:
			come.play_backwards("EnterLeft")
			goingBack = true
			gameScript.NPCapprovedornah(false)
			deniedReason()
			
			
			gameScript.startConvo(convoDenied)
		
		gameScript.stamped = false
	
	if can_be_deleted:
		if gameScript.timeshort.rotation_degrees < 210:
			gameScript.sendAnother()
		queue_free()

func deniedReason():
	match gameScript.reason:
		"e":
			pass


func ThrowOutDocuments():
	gameScript.startConvo(conversation)
	
	for n in documents.size():
		if documents[n] != null:
			Throw(documents[n])
		await wait_for_seconds(1.0)

func Throw(body):
	var instance = body.instantiate()
	gameScript.documentsToBeGiven += 1
	add_sibling(instance)
	instance.position = throw_out_documents.position
	instance.playAnimation()
	gameScript.stamped = false

func wait_for_seconds(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout


func _on_come_animation_finished(anim_name):
	if !goingBack:
		ThrowOutDocuments()
	else:
		can_be_deleted = true
