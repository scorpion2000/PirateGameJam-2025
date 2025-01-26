extends Control

class_name SpellManager

signal cast_result(result : bool)
# Holds the player's answer
var current_result: Array[bool] = [false, false, false, false]

# Holds correct result
var current_spell: Array[Spell]

var can_cast: bool = false

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
	can_cast = true
	current_spell = PlayerData.generate_spell()
	speak(GlobalSpells.spell_to_string(current_spell))
	
	%Wizard.animation_player.play("spell_start")
	await %Wizard.animation_player.animation_finished
	if can_cast:
		%Wizard.animation_player.play("spell_wait")
	


func cast_spell():
	pass


func _on_cast_button_down() -> void:
	if can_cast:
		if current_result == GlobalSpells.get_expected_result(current_spell):
			speak("Success")
			%TurnHandler._endOfTurn(true, 2)
		else:
			speak("Failure")
			%TurnHandler._endOfTurn(false)
		
		can_cast = false
		
		%Wizard.animation_player.play("spell_end")
		
		$SpellCooldown.start()
		await $SpellCooldown.timeout
		
		start_spell()


func speak(text: String):
	$WizardSpeechPanel.set_speech(text)


func _on_open_spell_book_button_down() -> void:
	PlayerData.spell_book.set_open()
	var tween = create_tween()
	tween.tween_property($OpenSpellBook/TextureRect, "rotation_degrees", 10.0, 0.1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property($OpenSpellBook/TextureRect, "rotation_degrees", 0.0, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)


func _on_hover_book(is_over: bool = true):
	if is_over:
		var tween = create_tween()
		tween.tween_property($OpenSpellBook/TextureRect, "position", Vector2(33, 49), 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUINT)
	else:
		var tween = create_tween()
		tween.tween_property($OpenSpellBook/TextureRect, "position", Vector2(33, 51), 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUINT)
