extends Button
class_name ToggleButton

signal button_toggled(_color : GlobalSpells.SpellColor , toggle : bool)

@export var spell_color : GlobalSpells.SpellColor 
@export var is_toggled: bool = false : 
	set(Value):
		is_toggled = Value
		button_toggled.emit(spell_color, Value)

var tween: Tween

func _ready() -> void:
	pivot_offset = size / 2
	self.modulate = Color(0.5,0.5,0.5) 
	
	pressed.connect(_on_button_toggled)
	button_down.connect(_on_button_down)

func _on_button_toggled():
	is_toggled = !is_toggled
	self.modulate = Color(1,1,1) if is_toggled else Color(0.5,0.5,0.5)
	
#func _on_button_down() -> void:
	#texture_rect.pivot_offset = texture_rect.size / 2
	#print(texture_rect.pivot_offset)
	#tween = create_tween()
	#tween.tween_property(texture_rect, "rotation_degrees", 10.0, 0.2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	#tween.tween_property(texture_rect, "rotation_degrees", 0.0, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)

func _on_button_down() -> void:
	tween = create_tween()
	tween.tween_property(self, "rotation_degrees", 10.0, 0.1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "rotation_degrees", 0.0, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
