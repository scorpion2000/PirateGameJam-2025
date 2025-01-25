extends Node
class_name TurnHandler

@export var enemyCycler : UIEnemyCycle
@export var player : Player

#TRUE if correct spell was cast
#This function is used to call fancy functions
func _endOfTurn(correctSpell : bool):
	if !correctSpell:
		player._addDamage(enemyCycler._getFirstDamage())
	enemyCycler._cycle(correctSpell)
	player._handleTurnDamage()

func _onCastResult(result: bool) -> void:
	_endOfTurn(result)
