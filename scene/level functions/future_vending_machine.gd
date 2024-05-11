extends CharacterBody2D
var shopping = false

func _ready():
	$Area2D/ShopMenu.visible = false
func _process(_delta):
	pass
func _on_area_2d_body_entered(body):
	if body.name == "Tony":
		get_tree().paused = true
		$Area2D/ShopMenu.visible = true
		shopping = true
func _on_area_2d_body_exited(body):
	if body.name == "Tony":
		$Area2D/ShopMenu.visible = false
		shopping = false
