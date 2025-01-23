extends Node2D
class_name UIEnemyCycle

@export var emptyImage : PackedScene

var imageWidth = 120
var sprites : Array[Enemy]
var DEBUG = false

func _cycle(removeFirst : bool):
	if !removeFirst:
		return
	var _first = sprites[0]
	sprites.remove_at(0)
	_first.queue_free()
	var i = 0;
	for sprite in sprites:
		var nextPos : Vector2 = Vector2(imageWidth * i, 0)
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(sprite, "position", nextPos, 0.25)
		i = i + 1
	if DEBUG:
			_DEBUG_generate_image(sprites.size())
	
	return

func _getFirstDamage():
	return sprites[0].damage

func _DEBUG_fill_array():
	DEBUG = true
	for i in range(0, 10):
		_DEBUG_generate_image(i)

func _DEBUG_generate_image(pos : int):
	var newSprite : Enemy = emptyImage.instantiate()
	add_child(newSprite)
	newSprite.position = Vector2(imageWidth * pos, 0)
	sprites.append(newSprite)
	newSprite._damageOverride(ceil(randf_range(2, 10)))
	if randf_range(0, 100) < 20:
		newSprite.damage.type = DamageType.Type.POISON
		newSprite._updateDisplay()
