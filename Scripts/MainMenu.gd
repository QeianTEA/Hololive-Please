extends Node2D

var simultaneous_scene = preload("res://Scenes/game.tscn").instantiate()

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
