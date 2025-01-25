extends Node2D
class_name UIEnemyCycle

@export var emptyImage : PackedScene
@export var monsterGenerator : EnemyGenerator
@export var maxMonsters : int = 7

var imageWidth = 40
var enemies : Array[Enemy]
var DEBUG = false

func _ready():
	if monsterGenerator != null:
		var _newEnemies = monsterGenerator._generatePatternless(maxMonsters)
		for _enemy in _newEnemies:
			_addEnemy(_enemy)
		get_node("DEBUG CYCLE").set_visible(false)
		get_node("DEBUG FILL").set_visible(false)

func _cycle(removeFirst : bool):
	if !removeFirst:
		_removeFirstEmpty()
		return
	var _first = enemies[0]
	enemies.remove_at(0)
	_first.queue_free()
	var i = 0;
	for sprite in enemies:
		_moveSprite(i, sprite)
		i = i + 1
	if DEBUG:
		_DEBUG_generate_image(enemies.size())
	_monsterRequest()

func _removeFirstEmpty():
	print("removing first empty enemy")
	var move = false
	var i = 0
	var pos : int = 0
	#print(str(enemies.size()))
	for sprite in enemies:
		#print(str(i))
		if !move && sprite.monsterType == Enemy.MonsterType.EMPTY:
			move = true
			pos = i
			#print("removed emtpy enemy at " + str(i))
		if move:
			_moveSprite(i - 1, sprite)
		i += 1
	if !move:
		return
	enemies[pos].queue_free()
	enemies.remove_at(pos)
	_monsterRequest()

func _monsterRequest():
	if monsterGenerator == null:
		return
	if maxMonsters - enemies.size() > 0:
		var _newMonsters : Array[Enemy] = monsterGenerator._generatePatternless(maxMonsters - enemies.size())
		for _enemy in _newMonsters:
			_addEnemy(_enemy)

func _moveSprite(i : int, sprite : Enemy):
	#print("Moving sprite at " + str(i) + " ; " + str(Enemy.MonsterType.keys()[sprite.monsterType]))
	var nextPos : Vector2 = Vector2(imageWidth * i, 0)
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(sprite, "position", nextPos, 0.25)

func _getFirstDamage():
	if enemies[0].monsterType == Enemy.MonsterType.EMPTY:
		return null
	return enemies[0].damage

func _DEBUG_fill_array():
	DEBUG = true
	for i in range(0, 10):
		_DEBUG_generate_image(i)

func _DEBUG_generate_image(pos : int):
	var newSprite : Enemy = emptyImage.instantiate()
	add_child(newSprite)
	newSprite.position = Vector2(imageWidth * pos, 0)
	enemies.append(newSprite)
	newSprite._damageOverride(ceil(randf_range(2, 10)))
	if randf_range(0, 100) < 20:
		newSprite.damage.type = DamageType.Type.POISON
		newSprite._updateDisplay()

func _addEnemy(enemy: Enemy):
	add_child(enemy)
	enemy.position = Vector2(imageWidth * enemies.size(), 0)
	enemies.push_back(enemy)
