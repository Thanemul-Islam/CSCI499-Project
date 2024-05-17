extends Node2D
signal impaled

func _on_area_2d_body_entered(body):
	if body.name == "Tony":
		impaled.emit()
