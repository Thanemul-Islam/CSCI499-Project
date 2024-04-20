extends Node2D

var down = Vector2.DOWN
var speed = 400

func _physics_process(delta):	
	global_position += down * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_hitbox_area_2d_body_entered(body):
	if body.name == "TileMap":
		queue_free()
