extends Node2D

# Detects character body of tony adds coin
func _on_area_2d_body_entered(body):
	if (body.name == "CharacterBody2D"):
		GameManager.gain_coins(1)
		queue_free()

