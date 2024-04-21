extends Node2D

@onready var box_container_text = $VBoxContainer/Text
@onready var choice_button_scn = preload("res://scene/choice_button.tscn")

var choice_buttons: Array[Button] = []
var is_dialogue_done = false

func _ready():
	pass
func clear_dialogue_box():
	box_container_text.text = ""
	for choice in choice_buttons:
		$VBoxContainer.remove_child(choice)
	choice_buttons = []

func add_text(text: String):
	box_container_text.text = text
	
func add_choice(choice_text: String):
	var button_obj: ChoiceButton = choice_button_scn.instantiate()
	button_obj.choice_index = choice_buttons.size()
	choice_buttons.push_back(button_obj)
	button_obj.text = choice_text
	button_obj.choice_selected.connect(_on_choice_selected)
	$VBoxContainer.add_child(button_obj)
	
func _on_choice_selected(choice_index: int):
	if !is_dialogue_done:
		($EzDialogue as EzDialogue).next(choice_index)
	else:
		clear_dialogue_box()
