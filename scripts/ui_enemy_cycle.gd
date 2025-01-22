extends Node2D

@export var emptyImage : PackedScene

var imageWidth = 30
var sprites : Array[Node2D]
var DEBUG = false

func _cycle():
	var _first = sprites[0]
	sprites.remove_at(0)
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
	_first.queue_free()
	return

func _DEBUG_fill_array():
	DEBUG = true
	for i in range(0, 50):
		_DEBUG_generate_image(i)

func _DEBUG_generate_image(pos : int):
	var newSprite : Node2D = emptyImage.instantiate()
	add_child(newSprite)
	newSprite.position = Vector2(imageWidth * pos, 0)
	sprites.append(newSprite)
