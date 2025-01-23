extends Node
class_name Player

@export var health : int = 10

var damageBuffer : Array[DamageType]
signal turnReady

@onready var healthLabel : Label = self.get_node("HealthLabel")

func _ready():
	_takeDamage(0)

func _handleTurnDamage():
	var _damageBuffer : Array[DamageType]
	for damage in damageBuffer:
		if damage.type == DamageType.Type.SLASH:
			_takeDamage(damage.hitPoint)
		if damage.type == DamageType.Type.POISON:
			_takeDamage(1)
			damage.hitPoint = damage.hitPoint - 1
			if damage.hitPoint > 0:
				_damageBuffer.push_back(damage)
	damageBuffer = _damageBuffer
	turnReady.emit()

func _addDamage(newDamage : DamageType):
	damageBuffer.push_back(newDamage)

#Insert fancy damage taking graphics here
func _takeDamage(damage : int):
	health = health - damage
	healthLabel.text = str(health)