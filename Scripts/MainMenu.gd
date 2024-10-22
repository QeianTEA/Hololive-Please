extends Node2D

var simultaneous_scene = preload("res://Scenes/game.tscn").instantiate()

@onready var start_b = $Menu/Buttons/Start/StartB
@onready var option_b = $Menu/Buttons/Option/OptionB
@onready var credit_b = $Menu/Buttons/Credite/CreditB
@onready var quit_b = $Menu/Buttons/Quit/QuitB

func _ready():
	start_b.self_modulate = Color(255,255,255,0)
	option_b.self_modulate = Color(255,255,255,0)
	credit_b.self_modulate = Color(255,255,255,0)
	quit_b.self_modulate = Color(255,255,255,0)

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_button_mouse_entered(number):
	match number:
		1:
			start_b.self_modulate = Color(255,255,255,255)
		2:
			option_b.self_modulate = Color(255,255,255,255)
		3:
			credit_b.self_modulate = Color(255,255,255,255)
		4:
			quit_b.self_modulate = Color(255,255,255,255)



func _on_button_mouse_exited(number):
	match number:
		1:
			start_b.self_modulate = Color(255,255,255,0)
		2:
			option_b.self_modulate = Color(255,255,255,0)
		3:
			credit_b.self_modulate = Color(255,255,255,0)
		4:
			quit_b.self_modulate = Color(255,255,255,0)
