extends Node
class_name TurnHandler

@export var enemyCycler : UIEnemyCycle
@export var player : Player
@export var rewardUi: Control

func _ready():
	if rewardUi != null:
		rewardUi.reward_selected.connect(_generateWave)

#TRUE if correct spell was cast
#This function is used to call fancy functions
func _endOfTurn(correctSpell : bool, playerDamage: int = 0):
	if !correctSpell:
		
		#Play animation
		if not enemyCycler._isFirstEmpty():
			enemyCycler._getFirst().animate_attack()
		
			#Deal damage during animation
			await enemyCycler.enemies[0]._on_attacked
			player._addDamage(enemyCycler._getFirstDamage())
			player._handleTurnDamage()
		
		enemyCycler._removeFirstEmpty()
	
	elif ! await _dealDamageToEnemy(playerDamage):
		
		enemyCycler.enemies[0].animate_attack()
		
		await enemyCycler._getFirstNoneEmpty()._on_attacked
		player._addDamage(enemyCycler._getFirstDamage())
		enemyCycler._removeFirstEmpty()
		player._handleTurnDamage()
		
		enemyCycler._cycle(enemyCycler._isFirstEmpty())
	else:
		enemyCycler._cycle(correctSpell)
	player._handleTurnDamage()
	
	_endOfWave()


func _onCastResult(result: bool) -> void:
	_endOfTurn(result)

func _dealDamageToEnemy(damage : int) -> bool:
	var _enemy : Enemy = enemyCycler._getFirstNoneEmpty()
	

	_enemy._takeDamage(damage)
	
	await player._on_attack_end
	
	$Hit.pitch_scale = randf_range(0.8, 1.2)
	$Hit.play()
	
	if _enemy.health <= 0:
		return true
	return false


func _generateWave():
	#This function has to be called when card selection was made
	if enemyCycler._getNonEmptyCount() != 0:
		return
	enemyCycler._monsterRequest()

func _endOfWave():
	if enemyCycler._getNonEmptyCount() != 0:
		return
	#Call the end of round card selection here
	rewardUi.activate_ui()
