extends Node2D

@export var speed: int = 150

var current_speed = 0

func _physics_process(delta):
	position.y += current_speed * delta

func _on_hitbox_area_entered(area):
	# call damage function
	if area.get_parent() is CharacterBody2D:
		# destroy itself if it hits player
		queue_free()

func _on_player_detection_area_entered(area):
	if area is CharacterBody2D:
		fall()

func fall():
	current_speed = speed
	# destroy itself after 5 seconds
	await get_tree().create_timer(5).timeout
	queue_free()
