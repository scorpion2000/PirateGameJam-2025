extends Node

# Stores info about the spell such as the word used and the conditions
class_name Spell

# The word that will appear when shouting out spells
var word: String

var conditions: Array[SpellCondition]


func _init(_word: String) -> void:
	self.word = _word


func add_condition(color: int, status: int) -> Spell:
	var condition: SpellCondition = SpellCondition.new(color, status)
	conditions.append(condition)
	return self
