extends Node
class_name TurnHandler

@export var enemyCycler : UIEnemyCycle
@export var player : Player

#TRUE if correct spell was cast
#This function is used to call fancy functions
func _endOfTurn(correctSpell : bool):
	enemyCycler._cycle(correctSpell)
	if !correctSpell:
		player._addDamage(enemyCycler._getFirstDamage())
	player._handleTurnDamage()

func _onCastResult(result: bool) -> void:
	_endOfTurn(result)
