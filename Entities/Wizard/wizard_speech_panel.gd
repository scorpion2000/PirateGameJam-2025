extends PanelContainer

class_name WizardSpeechPanel

var text: String = ""

@onready var speech: RichTextLabel = $Speech

func _ready() -> void:
	pass


func set_speech(message: String):
	text = ""
	
	for i in message:
		text += i
		await get_tree().create_timer(0.05).timeout
		speech.text = "[center][wave amp=10.0 freq=2.0 connected=1]%s[/wave][/center]" % text
