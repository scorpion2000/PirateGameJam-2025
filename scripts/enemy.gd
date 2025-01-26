extends Node2D
class_name Enemy

# This is a wrapper class.

enum MonsterType {GOBLIN, EMPTY}

const ENEMY_STATS = preload("res://Entities/Enemies/enemy_stats.tscn")
var enemy_stat_display: EnemyStatDisplay
@export var show_enemy_stats: bool = true

@export var monsterType : MonsterType = MonsterType.GOBLIN
## DEFAULT means the monster's predefined damage type is selected. [br]This allows us to alter a monster's default damage type
@export var damageType : DamageType.Type = DamageType.Type.DEFAULT
## How many damage a monster should deal
@export var damagePoints : int = 1
## -1 is the default value. On default value, the charged damage is double the normal damage. You can set a custom value here
@export var chargedDamagePoints : int = -1
## Bosses drop stuff
@export var boss : bool = false
@export var defaultHealth : int = 1

var health : int = 0
var damage : DamageType = DamageType.new()

func _ready():
	health = defaultHealth
	damage.hitPoint = damagePoints
	if (damageType != DamageType.Type.DEFAULT):
		damage.type = damageType
	else:
		match monsterType:
			MonsterType.GOBLIN:
				damage.type = DamageType.Type.SLASH
			_:
				damage.type = DamageType.Type.SLASH
	_updateDisplay()

func _updateDisplay():
	if enemy_stat_display:
		enemy_stat_display.health.text = "HP: %s" % str(health)
		enemy_stat_display.attack.text = "%s %s" % [DamageType.Type.keys()[damage.type], str(damage.hitPoint)]
		enemy_stat_display.progress_bar.value = health
	else:
		print("HUH")
	
	await get_tree().process_frame
	
	if GameManager.entity_stats_holder != null and show_enemy_stats and enemy_stat_display == null:
		enemy_stat_display = ENEMY_STATS.instantiate()
		GameManager.entity_stats_holder.add_child(enemy_stat_display)
		enemy_stat_display.linked_enemy = self
		enemy_stat_display.progress_bar.max_value = health
		enemy_stat_display.progress_bar.value = health
		
		if enemy_stat_display:
			enemy_stat_display.health.text = "HP: %s" % str(health)
			enemy_stat_display.attack.text = "%s %s" % [DamageType.Type.keys()[damage.type], str(damage.hitPoint)]
		else:
			print("HUH")


func _damageOverride(newDamage: int):
	damage.hitPoint = newDamage
	_updateDisplay()

func _takeDamage(damageTaken : int):
	health -= damageTaken
	
	_updateDisplay()
