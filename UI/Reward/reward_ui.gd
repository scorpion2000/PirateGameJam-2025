extends Control

enum RewardType { SPELL, STATS }

var stat_upgrades: Array = [25, 10, 5]  # Example stat values
var card_buttons: Array[RewardCard] = []

func _enter_tree() -> void:
	var buttons = %HBoxContainer.get_children()
	for button in buttons:
		if button is RewardCard:
			card_buttons.append(button)
			button.pressed.connect(_on_card_pressed)

func _ready() -> void:
	await get_tree().create_timer(2.0).timeout
	activate_ui()

func activate_ui():
	self.visible = true
	var rewards = get_rewards()
	for i in range(card_buttons.size()):
		var card = card_buttons[i]
		if i < rewards.size():
			var reward = rewards[i]
			match reward.type:
				RewardType.SPELL:
					card.setup_card(reward.spell.word, RewardCard.RewardType.SPELL, reward.spell)
				RewardType.STATS:
					card.setup_card("Heal by %d" % reward.stat, RewardCard.RewardType.STATS, reward.stat)
		else:
			card.visible = false

func get_rewards() -> Array:
	var rewards = []
	var new_spells = get_new_spells()
	
	for i in range(min(new_spells.size(), 2)):
		rewards.append({ "type": RewardType.SPELL, "spell": new_spells[i] })
	
	if stat_upgrades.size() > 0:
		var stat = stat_upgrades[randi() % stat_upgrades.size()]
		rewards.append({ "type": RewardType.STATS, "stat": stat })
	
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
