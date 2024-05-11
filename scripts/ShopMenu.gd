extends CanvasLayer
var player
var curr_item = 0
var select = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().find_child("Tony")

func switch_item(select):
	for i in range(GameManager.items.size()):
		if select == i:
			curr_item = select
			get_node("Name").text = GameManager.items[curr_item]["Name"]
			get_node("Des").text = GameManager.items[curr_item]["Des"]
			get_node("Des").text += "\nCost: " + str(GameManager.items[curr_item]["Cost"])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().paused = false
	$".".visible = false

func _on_purchase_pressed():
	if GameManager.items[curr_item]["Name"] == "Cola Serum" && GameManager.coins >= 20:
		GameManager.spend_coins(20)
		GameManager.player.SPEED = 450
		await get_tree().create_timer(100.00).timeout
		GameManager.player.SPEED = 300
	if GameManager.items[curr_item]["Name"] == "Nutrition Cube" && GameManager.coins >= 35:
		GameManager.spend_coins(35)
		GameManager.player.max_health += 1
		GameManager.player.health += 1
		GameManager.player.healthbar.init_health(GameManager.player.max_health)
		GameManager.player._set_health(GameManager.player.health)
		print (GameManager.player.max_health)
		print(GameManager.player.health)
		
	if GameManager.items[curr_item]["Name"] == "Adrenaline" && GameManager.coins >= 25:
		GameManager.spend_coins(25)
		GameManager.player.SPEED = 400
		GameManager.player.JUMP_VELOCITY = -575
		await get_tree().create_timer(100.00).timeout
		GameManager.player.SPEED = 300
		GameManager.player.JUMP_VELOCITY = -500
		
func _on_next_pressed():
	switch_item(curr_item + 1)


func _on_back_pressed():
	switch_item(curr_item - 1)
