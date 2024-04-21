extends Node2D

@export var dialogue_json: JSON
@onready var state = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	($DialogueBox/EzDialogue as EzDialogue).start_dialogue(dialogue_json, state)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_ez_dialogue_dialogue_generated(response):
	$DialogueBox.clear_dialogue_box()
	$DialogueBox.add_text(response.text)
	for choice in response.choices:
		$DialogueBox.add_choice(choice)

func _on_ez_dialogue_end_of_dialogue_reached():
	$DialogueBox.is_dialogue_done = true
