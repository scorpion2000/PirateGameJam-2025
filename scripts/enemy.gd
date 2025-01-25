extends Node2D
class_name Enemy

# This is a wrapper class.

enum MonsterType {GOBLIN, EMPTY}

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

@onready var damageValueText : Label = self.get_node("Info Panel").get_node("Damage Value")
@onready var damageTypeText : Label = self.get_node("Info Panel").get_node("Damage Type")
@onready var healthText : Label = self.get_node("Control").get_node("Health")

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
	damageValueText.text = str(damage.hitPoint)
	damageTypeText.text = DamageType.Type.keys()[damage.type]
	healthText.text = str(health)

func _damageOverride(newDamage: int):
	damage.hitPoint = newDamage
	_updateDisplay()

func _takeDamage(damageTaken : int):
	health -= damageTaken
	_updateDisplay()