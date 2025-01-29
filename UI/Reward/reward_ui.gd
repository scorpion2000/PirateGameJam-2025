extends Control

enum RewardType { SPELL, STATS }

var stat_upgrades: Array = [25, 10, 5]  # Example stat values
var card_buttons: Array[RewardCard] = []

signal reward_selected

func _enter_tree() -> void:
	var buttons = %HBoxContainer.get_children()
	for button in buttons:
		if button is RewardCard:
			card_buttons.append(button)
			button.pressed.connect(_on_card_pressed)

func _ready() -> void:
	await get_tree().create_timer(2.0).timeout
	#activate_ui()

func activate_ui():
	self.visible = true
	var rewards = get_rewards()
	for i in range(card_buttons.size()):
		var card = card_buttons[i]
		if i < rewards.size():
			var reward = rewards[i]
			if randf() >= 0.8 and PlayerData.spell_size > 2:
				card.setup_card(reward, RewardCard.RewardType.SPELL_SIZE)
			else:
				card.setup_card(reward, randi_range(0, 2))
		else:
			card.visible = false

func get_rewards() -> Array:
	var rewards = get_new_spells()
	
	rewards.shuffle()
	return rewards

func get_new_spells() -> Array:
	var available_spells = []
	for spell in PlayerData.spell_pool:
		if spell not in PlayerData.spells:
			available_spells.append(spell)
	return available_spells

func _on_card_pressed():
	self.visible = false
	reward_selected.emit()
	$"../SpellPanel".start_spell()
