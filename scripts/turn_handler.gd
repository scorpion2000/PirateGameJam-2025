extends Node
class_name TurnHandler

@export var enemyCycler : UIEnemyCycle
@export var player : Player

#TRUE if correct spell was cast
#This function is used to call fancy functions
func _endOfTurn(correctSpell : bool, playerDamage: int = 0):
	if !correctSpell:
		player._addDamage(enemyCycler._getFirstDamage())
		enemyCycler._removeFirstEmpty()
	elif !_dealDamageToEnemy(playerDamage):
		player._addDamage(enemyCycler._getFirstDamage())
		enemyCycler._removeFirstEmpty()
	else:
		enemyCycler._cycle(correctSpell)
	player._handleTurnDamage()

func _onCastResult(result: bool) -> void:
	_endOfTurn(result)

func _dealDamageToEnemy(damage : int) -> bool:
	var _enemy : Enemy = enemyCycler._getFirstNoneEmpty()
	_enemy._takeDamage(damage)
	if _enemy.health <= 0:
		return true
	return false
