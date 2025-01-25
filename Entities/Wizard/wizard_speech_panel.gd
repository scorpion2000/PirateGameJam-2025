extends Control

class_name WizardSpeechPanel

var target: String = ""
var text: String = ""

@onready var speech: Label = $Speech

func _ready() -> void:
	pass


func set_speech(message: String):
	target = message
	text = ""
	
	for i in message:
		if target == message:
			text += i
			await get_tree().create_timer(0.05).timeout
			speech.text = text
