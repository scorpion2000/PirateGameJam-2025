extends Node

enum SpellColor {RED, BLUE, GREEN, YELLOW}
enum SpellStatus {ON, OFF, SWITCH}

# Global list of Spells
var spells: Array[Spell] = [
	
	Spell.new("Boop").add_condition(SpellColor.RED, SpellStatus.SWITCH).add_condition(SpellColor.BLUE, SpellStatus.SWITCH),
	Spell.new("Shazam").add_condition(SpellColor.BLUE, SpellStatus.ON).add_condition(SpellColor.YELLOW, SpellStatus.ON),
	Spell.new("Pocus").add_condition(SpellColor.YELLOW, SpellStatus.SWITCH).add_condition(SpellColor.GREEN, SpellStatus.ON),
	Spell.new("Kazam").add_condition(SpellColor.GREEN, SpellStatus.ON).add_condition(SpellColor.BLUE, SpellStatus.SWITCH).add_condition(SpellColor.YELLOW, SpellStatus.ON),
	Spell.new("Expecto").add_condition(SpellColor.GREEN, SpellStatus.OFF),
	Spell.new("Chango").add_condition(SpellColor.RED, SpellStatus.SWITCH).add_condition(SpellColor.BLUE, SpellStatus.SWITCH).add_condition(SpellColor.GREEN, SpellStatus.SWITCH).add_condition(SpellColor.YELLOW, SpellStatus.SWITCH),
	Spell.new("Boom").add_condition(SpellColor.RED, SpellStatus.ON).add_condition(SpellColor.YELLOW, SpellStatus.ON),
	Spell.new("Meeska").add_condition(SpellColor.RED, SpellStatus.ON).add_condition(SpellColor.YELLOW, SpellStatus.OFF),
	Spell.new("Mooska").add_condition(SpellColor.BLUE, SpellStatus.ON).add_condition(SpellColor.GREEN, SpellStatus.OFF),
]


var starter_spells: Array[Spell] = [
	
	Spell.new("Abra").add_condition(SpellColor.RED, SpellStatus.OFF),
	Spell.new("Kadabra").add_condition(SpellColor.BLUE, SpellStatus.ON),
	Spell.new("Hocus").add_condition(SpellColor.GREEN, SpellStatus.ON),
	Spell.new("Presto").add_condition(SpellColor.RED, SpellStatus.ON).add_condition(SpellColor.YELLOW, SpellStatus.OFF),
	
]


func get_expected_result(input: Array[Spell]):
	var result: Array[bool] = [false, false, false, false]
	
	for spell in input:
		
		for condition in spell.conditions:
			
			match condition.color:
				SpellColor.RED:
					result[0] = get_color_status(result[0], condition.status)
				SpellColor.BLUE:
					result[1] = get_color_status(result[1], condition.status)
				SpellColor.GREEN:
					result[2] = get_color_status(result[2], condition.status)
				SpellColor.YELLOW:
					result[3] = get_color_status(result[3], condition.status)
	
	return result

func get_spell_result(input : Spell):
	var result: Array[bool] = [false, false, false, false]

	for condition in input.conditions:
		
		match condition.color:
			SpellColor.RED:
				result[0] = get_color_status(result[0], condition.status)
			SpellColor.BLUE:
				result[1] = get_color_status(result[1], condition.status)
			SpellColor.GREEN:
				result[2] = get_color_status(result[2], condition.status)
			SpellColor.YELLOW:
				result[3] = get_color_status(result[3], condition.status)
	
	return result

# Checks if a certain button should be on or off
func get_color_status(current_status, change):
	
	var result = current_status
	
	match change:
		SpellStatus.ON:
			result = true
		SpellStatus.OFF:
			result = false
		SpellStatus.SWITCH:
			result = !result
	
	return result


func spell_to_string(input: Array[Spell]):
	var text = ""
	
	for i in input.size():
		
		text += input[i].word
		if i != input.size() - 1:
			text += "-"
	
	return text
