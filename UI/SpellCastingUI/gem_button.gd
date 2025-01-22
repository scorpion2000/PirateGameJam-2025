extends Button


@onready var texture_rect: TextureRect = $TextureRect
var tween: Tween


func _on_button_down() -> void:
	tween = get_tree().create_tween()
	tween.tween_property(texture_rect, "rotation_degrees", 10, 0.2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(texture_rect, "rotation_degrees", 0, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.bind_node(self)
