extends Control

class_name SpellManager

signal cast_result(result : bool)
# Holds the player's answer
var current_result: Array[bool] = [false, false, false, false]

# Holds correct result
var current_spell: Array[Spell]

var can_cast: bool = false

@onready var success_sound: AudioStreamPlayer = $Success
@onready var failure_sound: AudioStreamPlayer = $Failure
@onready var wizard_talk_sound: AudioStreamPlayer = $WizardTalk

func _ready() -> void:
	await get_tree().process_frame
	
	$HBoxContainer/Red.button_toggled.connect(update_result)
	$HBoxContainer/Blue.button_toggled.connect(update_result)
	$HBoxContainer/Green.button_toggled.connect(update_result)
	$HBoxContainer/Yellow.button_toggled.connect(update_result)
	
	await get_tree().create_timer(0.5).timeout
	
	start_spell()


func _process(delta: float) -> void:
	if not PlayerData.player.is_dead:
		if Input.is_action_just_pressed("open_spell_book"):
			toggle_open_book()
		
		
		if Input.is_action_just_pressed("cast_spell"):
			cast_spell()
		
		
		if Input.is_action_just_pressed("toggle_red"):
			$HBoxContainer/Red.toggle()
			$HBoxContainer/Red.animate_button_press()
		if Input.is_action_just_pressed("toggle_blue"):
			$HBoxContainer/Blue.toggle()
			$HBoxContainer/Blue.animate_button_press()
		if Input.is_action_just_pressed("toggle_green"):
			$HBoxContainer/Green.toggle()
			$HBoxContainer/Green.animate_button_press()
		if Input.is_action_just_pressed("toggle_yellow"):
			$HBoxContainer/Yellow.toggle()
			$HBoxContainer/Yellow.animate_button_press()


func update_result(spell_color: GlobalSpells.SpellColor, value):
	current_result[spell_color] = value
	print(current_result)


func start_spell():
	can_cast = true
	current_spell = PlayerData.generate_spell()
	speak(GlobalSpells.spell_to_string(current_spell))
	
	%Wizard.animation_player.play("spell_start")
	await %Wizard.animation_player.animation_finished
	if can_cast and not PlayerData.player.is_dead:
		%Wizard.animation_player.play("spell_wait")


func cast_spell():
	if can_cast and not PlayerData.player.is_dead:
		if current_result == GlobalSpells.get_expected_result(current_spell):
			speak("Success")
			%TurnHandler._endOfTurn(true, PlayerData.base_attack)
			success_sound.pitch_scale = randf_range(0.9, 1.1)
			success_sound.play()
			%Wizard.get_parent().shoot_bullet(%EnemyCycler._getFirstNoneEmpty().global_position.x, %EnemyCycler._getPositionOfFirstNoneEmpty())
		else:
			speak("Failure")
			%TurnHandler._endOfTurn(false)
			failure_sound.pitch_scale = randf_range(0.9, 1.1)
			failure_sound.play()
		
		can_cast = false
		
		%Wizard.animation_player.play("spell_end")
		await %Wizard.animation_player.animation_finished
		%Wizard.get_parent()._on_attack_end.emit()
		
		$SpellCooldown.start()
		await $SpellCooldown.timeout
		
		if %EnemyCycler._getNonEmptyCount() > 0:
			start_spell()


func _on_cast_button_down() -> void:
	cast_spell()


func speak(text: String):
	$WizardSpeechPanel.set_speech(text)


func _on_open_spell_book_button_down() -> void:
	toggle_open_book()


func toggle_open_book():
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
