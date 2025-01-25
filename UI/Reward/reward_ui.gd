extends Control

var card_buttons : Array[RewardCard]

func _enter_tree() -> void:
	var buttons = %HBoxContainer.get_children()
	for button in buttons:
		if button is RewardCard:
			card_buttons.append(button)

func _ready() -> void:
	activate_ui()

func activate_ui():
	for card in card_buttons:
		var new_spell = get_new_spell()
		if new_spell != null:
			card.card_spell = new_spell
			card.type_label.text = "Spell: "
			card.description_label.text = card.card_spell.word
		
func get_new_spell():
	if PlayerData.spells.size() == GlobalSpells.spells.size(): return null
	
	var new_spell: Spell
	while true:
		new_spell = GlobalSpells.spells.pick_random()
		if new_spell not in PlayerData.spells:
			return new_spell
	
func _on_card_pressed(spell: Spell) -> void:
	print(spell)
