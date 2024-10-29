extends Node2D

var paper_stack = []
#const paper_scene = preload("res://Scenes/Documents/document.tscn") #test

var NPCobject: PackedScene = preload("res://Scenes/npc.tscn")

var yesMark : Texture = preload("res://Sprites/Documents/allowedstampmark.png")
var noMark : Texture = preload("res://Sprites/Documents/deniedstampmark.png")
var paperCanBeYes = null
var paperCanBeNo = null

@export var text_box = Control

var documentsToBeGiven: int
var stamped: bool
var approved: bool

var reason: String

var inspectMode: bool



@onready var npc_collider = $Background/Collisions/NpcCollider


@onready var blindsAnimation = $Background/Blinds/AnimationPlayer
@onready var blinds_up_button = $Buttons/BlindsUpButton
@onready var blinds_down_button = $Buttons/BlindsDownButton

@onready var stampOpenAnimation = $Background/Stampbarmain/StampAnimtoin
@onready var stamp_open_button = $Buttons/StampOpenButton
@onready var stamp_close_button = $Buttons/StampCloseButton

var stampsAvailable = false
@onready var stamp_noAnimation = $Background/Stampbarmain/Stampbarno/Stampbarhead/StampNo
@onready var stamp_yesAnimation = $Background/Stampbarmain/Stampbaryes/Stampbarhead2/StampYes
@onready var no_marker = $Background/Stampbarmain/StampNoArea/NoMarker
@onready var yes_marker = $Background/Stampbarmain/StampYesArea/YesMarker
@onready var stamp_no_area = $Background/Stampbarmain/StampNoArea
@onready var stamp_yes_area = $Background/Stampbarmain/StampYesArea



# Called when the node enters the scene tree for the first time
#	for i in range(0, 2):
#		var paper = paper_scene.instantiate()
#		add_child(paper)
#		add_paper(paper)

func _ready():
	stampsAvailable = false
	stamp_close_button.disabled = true
	documentsToBeGiven = 0
	stamped = false

func _physics_process(delta):
	
	# NPC stuff
	
	if documentsToBeGiven > 0 and !stamped:
		npc_collider.disabled = false  #closed to give
	else:
		npc_collider.disabled = true   #open to give
	
	
	#STAMPS
	
	if stampsAvailable && stamp_no_area.has_overlapping_bodies():
		var body = []
		var bodyPapers = []
		body = stamp_no_area.get_overlapping_bodies()
		for i in body.size():
			if body[i].is_in_group("Papers"):
				bodyPapers.append(body[i])
		if bodyPapers.size() == 1:
			paperCanBeNo = bodyPapers[0]
		else:
			for j in bodyPapers.size():
					if bodyPapers[j].chossen:
						paperCanBeNo = bodyPapers[j]
	
	if stampsAvailable && stamp_yes_area.has_overlapping_bodies():
		var body = []
		var bodyPapers = []
		body = stamp_yes_area.get_overlapping_bodies()
		for i in body.size():
			if body[i].is_in_group("Papers"):
				bodyPapers.append(body[i])
		if bodyPapers.size() == 1:
			paperCanBeYes = bodyPapers[0]
		else:
			for j in bodyPapers.size():
					if bodyPapers[j].chossen:
						paperCanBeYes = bodyPapers[j]
	
	

func sendAnother():
	var npc= NPCobject.instantiate()
	await get_tree().create_timer(3).timeout
	add_child(npc)

func startConvo(convo):
	text_box.start_conversation(convo)

func add_paper(paper): #latests appear have the top count
	paper_stack.append(paper)
	
	var count = 0
	for p in paper_stack:
		p.z_index = count
		count += 1


func push_paper_to_top(paper):
	paper_stack.erase(paper)
	if !stamped:
		add_paper(paper)


func _on_blinds_button_pressed():
		blinds_up_button.disabled = true
		blinds_down_button.disabled = false
		blindsAnimation.play("BlindsAnim")


func _on_blinds_down_button_pressed():
		blinds_down_button.disabled = true
		stampsAvailable = false
		blinds_up_button.disabled = false
		blindsAnimation.play_backwards("BlindsAnim")


func _on_stamp_open_button_pressed():
	stamp_open_button.disabled = true
	stampsAvailable = true
	stamp_close_button.disabled = false
	stampOpenAnimation.play("StampBarOpenClose")


func _on_stamp_close_button_pressed():
	stamp_open_button.disabled = false
	stampsAvailable = false
	stamp_close_button.disabled = true
	stampOpenAnimation.play_backwards("StampBarOpenClose")


func _on_stamp_no_button_pressed():
	stamp_noAnimation.play("StampGoDown")
	if paperCanBeNo != null and paperCanBeNo.canBeStamped:
		print("print it out baby")
		if !stamped:
			stamped = true
			approved = false
		
		var mark_instance = Sprite2D.new()
		mark_instance.texture = noMark
		mark_instance.scale = Vector2(1.1,1.1)
		mark_instance.position = paperCanBeNo.to_local(no_marker.get_global_position())
		paperCanBeNo.clipper.add_child(mark_instance)  # Add the mark to the scene



func _on_stamp_yes_button_pressed():
	stamp_yesAnimation.play("StampYes")
	if paperCanBeYes != null and paperCanBeYes.canBeStamped:
		print("print it out baby")
		if !stamped:
			stamped = true
			approved = true
		
		var mark_instance = Sprite2D.new()
		mark_instance.texture = yesMark
		mark_instance.scale = Vector2(1.1,1.1)
		mark_instance.position = paperCanBeYes.to_local(yes_marker.get_global_position())
		paperCanBeYes.clipper.add_child(mark_instance)  # Add the mark to the scene

func _on_stamp_yes_area_body_exited(body):
		if body == paperCanBeYes:
			paperCanBeYes = null
			print("no more")

func _on_stamp_no_area_body_exited(body):
	if body == paperCanBeNo:
		paperCanBeNo = null
		print("no more")


func _on_npc_paper_giver_body_entered(body):
	body.givable = true



func _on_npc_paper_giver_body_exited(body):
	body.givable = false



func _on_inspect_button_toggled(toggled_on):
	if toggled_on:
		inspectMode = true
		$TextureButton/InspectionMode.visible = true
	else:
		inspectMode = false
		$TextureButton/InspectionMode.visible = false
