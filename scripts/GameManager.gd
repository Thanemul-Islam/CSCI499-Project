extends Node

signal spent_coins()
signal gained_coins()
var coins : int = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var learned_double_jump = true
var learned_dash = true
var learned_attack = true
var items = {
	0: {
		"Name": "Cola Serum",
		"Des": "this item allows you to run faster",
		"Cost": 20
	},
	1: {
		"Name": "Nutrition Cube",
		"Des": "this item grants perma increased 1HP",
		"Cost": 35
	},
	2: {
		"Name": "Adrenaline",
		"Des": "this item grants speed and jump boost",
		"Cost": 25
	},
}

var current_checkpoint : Checkpoint

var player : Player

func respawn_player():
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position

func gain_coins(coins_gained : int):
	coins += coins_gained
	emit_signal("gained_coins")
	
func spend_coins(coins_spent: int):
	coins -= coins_spent
	emit_signal("spent_coins")

