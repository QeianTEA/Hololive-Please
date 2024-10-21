extends Node2D

var paper_stack = []
#const paper_scene = preload("res://Scenes/Documents/document.tscn") #test

@onready var blindsAnimation = $Background/Blinds/AnimationPlayer
@onready var blinds_up_button = $Buttons/BlindsUpButton
@onready var blinds_down_button = $Buttons/BlindsDownButton



# Called when the node enters the scene tree for the first time
#	for i in range(0, 2):
#		var paper = paper_scene.instantiate()
#		add_child(paper)
#		add_paper(paper)

func _ready():
	pass










func add_paper(paper): #latests appear have the top count
	paper_stack.append(paper)
	
	var count = 0
	for p in paper_stack:
		p.z_index = count
		
		count += 1

func push_paper_to_top(paper):
	paper_stack.erase(paper)
	add_paper(paper)


func _on_blinds_button_pressed():
		blinds_up_button.disabled = true
		blinds_down_button.disabled = false
		blindsAnimation.play("BlindsAnim")


func _on_blinds_down_button_pressed():
		blinds_down_button.disabled = true
		blinds_up_button.disabled = false
		blindsAnimation.play_backwards("BlindsAnim")
