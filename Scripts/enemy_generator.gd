extends Node
class_name EnemyGenerator

@export var enemies : Array[PackedScene]
@export var bosses : Array[PackedScene]
## Controls how often a boss spawns
@export var bossAfterX : int = 10
@export var enemyPatterns : Array[Enemy.MonsterType]

var spawnedEnemies = 0

func _generatePatternless(volume : int) -> Array[Enemy]:
	var enemyGroup : Array[Enemy]
	for x in range(0, volume):
		spawnedEnemies = spawnedEnemies + 1
		if (spawnedEnemies % bossAfterX == 0):
			enemyGroup.push_back(bosses.pick_random().instantiate())
			continue
		enemyGroup.push_back(enemies.pick_random().instantiate())
	return enemyGroup