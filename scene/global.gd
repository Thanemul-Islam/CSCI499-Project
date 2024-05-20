extends Node

func _ready():
	SilentWolf.configure({
		"api_key": "lGKyiZkQNr9KwlrXG2Kh29iOGprYC4596tjGM7VJ",
		"game_id": "ratthroughtime",
		"log_level": 2
	})

	SilentWolf.configure_scores({
		"open_scene_on_close": "res://scenes/main_menu.tscn"
	})

	SilentWolf.configure_auth({
		"redirect_to_scene": "res://scene/main_menu.tscn",
		"Login_scene": "res://addons/silent_wolf/Auth/Login.tscn",
#		"email_confirmation_scene": "res://addons/silent_wolf/Auth/ConfirmEmail.tscn", #
		"reset_password_scene": "res://addons/silent_wolf/Auth/ResetPassword.tscn",
		"session_duration_seconds": 0,
		"saved_session_expiration_days": 30
	})
