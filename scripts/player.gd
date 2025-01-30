extends Node
class_name Player

var damageBuffer : Array[DamageType]
signal turnReady
signal _on_attack_end

@onready var healthLabel : Label = $"../CanvasLayer/SpellPanel/ProgressBar/Health"
@onready var progress_bar: ProgressBar = $"../CanvasLayer/SpellPanel/ProgressBar"
@onready var spritePos : Node2D = $Wizard
@onready var bullet: Sprite2D = $Bullet
@onready var blast: Sprite2D = $Blast

var max_health: int :
	set(value):
		max_health = value
		if progress_bar.value >= value:
			progress_bar.value = value
		progress_bar.max_value = value
	
var health : int :
	set(value):
		health = value
		if healthLabel: healthLabel.text = str(value)
		progress_bar.value = value

func _ready():
	
	PlayerData.player = self
	
	var bullet_tween: Tween = create_tween()
	bullet_tween.bind_node(bullet)
	bullet_tween.tween_property(bullet, "scale", Vector2(1, 0.8), 0.3).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	bullet_tween.tween_property(bullet, "scale", Vector2(1, 1), 0.3).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	bullet_tween.set_loops()
	
	health = PlayerData.base_health
	max_health = PlayerData.base_health

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
	if newDamage == null:
		return
	damageBuffer.push_back(newDamage)

#Insert fancy damage taking graphics here
func _takeDamage(damage : int):
	health = health - damage
	var damageIndicator : DamageIndicator = DamageIndicator.new()
	damageIndicator.damage = damage
	damageIndicator.global_position = spritePos.global_position
	add_child(damageIndicator)
	$Hit.pitch_scale = randf_range(0.8, 1.2)
	$Hit.play()


func shoot_bullet(x_pos: float, speed: int = 1):
	bullet.global_position = spritePos.shoot_point.global_position
	bullet.show()
	
	var tween: Tween = create_tween()
	
	tween.tween_property(bullet, "position", Vector2(x_pos, bullet.position.y), 0.1 * (speed + 1))
	
	await tween.finished
	_on_attack_end.emit()
	bullet.hide()
	
	blast.global_position = bullet.global_position
	blast.show()
	
	tween = create_tween()
	tween.tween_property(blast, "scale", Vector2(1.2, 1.2), 0.1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(blast, "scale", Vector2(1, 1), 0.1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	
	await tween.finished
	
	blast.hide()
