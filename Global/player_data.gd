extends Node

# Hold players current unlocked spells. Unlocks 2 random spells at the start
var spells: Array[Spell]

# Maximum spell size for how many words can be in one full spell, minimum is 2
var spell_size: int = 3

# Holds all spells that could be added to the player's inventory, to avoid duplicate words
var spell_pool: Array[Spell]

var spell_book: SpellBook = null


var base_health: int = 30
var base_attack: int = 5

var player: Player = null

signal death

func setup_new_player_data():
	spell_size = 2
	base_health = 30
	base_attack = 5
	spells.clear()
	spell_pool.clear()
	spell_pool = GlobalSpells.spells.duplicate()
	
	await get_tree().process_frame
	
	# Add 2 random spells to start
	add_starter_spells()


func add_starter_spells():
	var starter_pool = GlobalSpells.starter_spells.duplicate()
	
	for i in 2:
		var index: int = randi_range(0, starter_pool.size() - 1)
		spell_book.add_spell(starter_pool[index])
		spells.append(starter_pool[index])
		starter_pool.remove_at(index)


func add_spell(index: int):
	spell_book.add_spell(spell_pool[index])
	spells.append(spell_pool[index])
	spell_pool.remove_at(index)


func generate_spell():
	var current_spells: Array[Spell] = spells.duplicate()
	var selected_spells: Array[Spell]
	var max_size = spell_size
	
	if spells.size() < spell_size:
		max_size = spells.size()
	
	for i in max_size:
		var random = randi_range(0, current_spells.size() - 1)
		selected_spells.append(current_spells[random])
		current_spells.remove_at(random)
	
	return selected_spells
