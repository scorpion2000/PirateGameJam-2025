extends Node
class_name EnemyGenerator

@export var emptyEnemy : PackedScene
@export var enemies : Array[PackedScene]
@export var bosses : Array[PackedScene]
## Controls how often a boss spawns
@export var bossAfterX : int = 10
@export var enemyPatterns : Array[Enemy.MonsterType]

var spawnedEnemies = 0
var spawnedBosses = 0
var wavesSpawned = randi_range(0,2)

func _generatePatternless(volume : int, last : bool = false) -> Array[Enemy]:
	var enemyGroup : Array[Enemy]
	if last:
		enemyGroup.push_back(enemies.pick_random().instantiate())
		return enemyGroup
	for x in range(0, volume):
		spawnedEnemies = spawnedEnemies + 1
		if (spawnedEnemies % bossAfterX == 0 && wavesSpawned > 2):
			enemyGroup.push_back(bosses.pick_random().instantiate())
			spawnedBosses += 1
			continue
		if randf() < 0.10:
			enemyGroup.push_back(emptyEnemy.instantiate())
		else:
			enemyGroup.push_back(enemies.pick_random().instantiate())
	return enemyGroup
