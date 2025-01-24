extends Node

# Hold players current unlocked spells. Unlocks 2 random spells at the start
var spells: Array[Spell]

# Maximum spell size for how many words can be in one full spell, minimum is 2
var spell_size: int = 2

# Holds all spells that could be added to the player's inventory, to avoid duplicate words
var spell_pool: Array[Spell]


func _ready() -> void:
	spell_pool = GlobalSpells.spells.duplicate()
	
	# Add 2 random spells to start
	for i in 2:
		var random: int = randi_range(0, spell_pool.size() - 1)
		add_spell(random)
	
	# Just to debug, delete if you will
	for i in generate_spell():
		print(i.word)


func add_spell(index: int):
	spells.append(spell_pool[index])
	spell_pool.remove_at(index)


func generate_spell():
	var current_spells: Array[Spell] = spells
	var selected_spells: Array[Spell]
	var max_size = spell_size
	
	if spell_size < spells.size():
		spell_size = spells.size()
	
	for i in spell_size:
		var random = randi_range(0, current_spells.size() - 1)
		selected_spells.append(current_spells[random])
		current_spells.remove_at(random)
	
	return selected_spells
