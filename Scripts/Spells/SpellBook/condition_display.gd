extends TextureRect

@onready var mark: TextureRect = $Mark

var current_mark: GlobalSpells.SpellStatus:
	set(value):
		current_mark = value
		mark.texture.region = Rect2(8 * value, 9, 9, 9)


func _ready() -> void:
	current_mark = 1
