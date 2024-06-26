extends Control
func _ready ():
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	$".".visible = false
	$AnimationPlayer.play_backwards ("blur")

func pause():
	get_tree().paused = true
	$".".visible = true
	$AnimationPlayer.play("blur")

func testEsc() :
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()



func _on_resume_pressed():
	resume()


func _on_restart_pressed():
	resume()
	get_tree().reload_current_scene()


func _on_quit_pressed():
	get_tree().paused = false
	$".".visible = false
	get_tree().change_scene_to_file("res://scene/world and level select/world_select.tscn")

func _process(delta):
	testEsc()
