extends Node2D


var direction : Vector2 
var speed = 700

func _process(delta):
	global_position += direction * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_attack_box_area_2d_area_entered(area):
	if area.get_parent() is Player:
		pass
	else:
		queue_free()


func _on_attack_box_area_2d_body_entered(body):
	
	if body is TileMap:
		queue_free()
