extends Control

@export var login_state_label: Label
@export var data_label: Label

@export var key_edit_1: TextEdit
@export var key_edit_2: TextEdit
@export var data_edit_1: TextEdit
@export var data_edit_2: TextEdit
# Called when the node enters the scene tree for the first time.
func _ready():
	$"VBoxContainer/Register Button".grab_focus()
	SilentWolf.Auth.sw_session_check_complete.connect(_on_login_complete)
	SilentWolf.Auth.sw_login_complete.connect(_on_login_complete)
	SilentWolf.Auth.sw_logout_complete.connect(_on_logout_complete)
	
	SilentWolf.Auth.auto_login_player()

func _on_register_button_pressed():
	get_tree().change_scene_to_file("res://addons/silent_wolf/Auth/Register.tscn")

func _on_login_button_pressed():
	get_tree().change_scene_to_file("res://addons/silent_wolf/Auth/Login.tscn")

func _on_logout_button_pressed():
	SilentWolf.Auth.logout_player()
	
func _on_logout_complete(a, b):
	update_login_state_label()
		
func _on_login_complete(sw_result):
	update_login_state_label()
		
func update_login_state_label():
	if SilentWolf.Auth.logged_in_player:
		login_state_label.text = "Logged in"
	else:
		login_state_label.text = "Not logged in"

func testEsc() :
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		get_tree().change_scene_to_file("res://scene/main_menu.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	testEsc()
