extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func testEsc() :
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		get_tree().change_scene_to_file("res://scene/main_menu.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	testEsc()
