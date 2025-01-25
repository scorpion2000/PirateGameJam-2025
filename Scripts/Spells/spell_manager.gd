extends Control

class_name SpellManager

signal cast_result(result : bool)
# Holds the player's answer
var current_result: Array[bool] = [false, false, false, false]

# Holds correct result
var current_spell: Array[Spell]

func _ready() -> void:
	await get_tree().process_frame
	
	$HBoxContainer/Red.button_toggled.connect(update_result)
	$HBoxContainer/Blue.button_toggled.connect(update_result)
	$HBoxContainer/Green.button_toggled.connect(update_result)
	$HBoxContainer/Yellow.button_toggled.connect(update_result)
	
	start_spell()


func update_result(spell_color: GlobalSpells.SpellColor, value):
	current_result[spell_color] = value
	print(current_result)


func start_spell():
	current_spell = PlayerData.generate_spell()
	speak(GlobalSpells.spell_to_string(current_spell))


func cast_spell():
	pass


func _on_cast_button_down() -> void:
	if current_result == GlobalSpells.get_expected_result(current_spell):
		speak("Success")
		cast_result.emit(true)
	else:
		speak("Failure")
		cast_result.emit(false)


func speak(text: String):
	$WizardSpeechPanel.set_speech(text)


func _on_open_spell_book_button_down() -> void:
	PlayerData.spell_book.set_open()
