extends Control

func _ready():
	$VBoxContainer/Play.grab_focus()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scene/world and level select/world_select.tscn" )

func _on_leaderboards_pressed():
	get_tree().change_scene_to_file("res://scene/Leaderboards.tscn")

func _on_sign_in_pressed():
	get_tree().change_scene_to_file("res://scene/Authentication.tscn")

func _on_quit_pressed():
	get_tree().quit()
