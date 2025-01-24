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
		spells.append(spell_pool[random])
		spell_pool.remove_at(random)
	
