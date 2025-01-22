extends Button
class_name ToggleButton

signal button_toggled(_color : GlobalSpells.SpellColor , toggle : bool)

@export var Spell_Color : GlobalSpells.SpellColor 
@export var is_toggled: bool = false : 
	set(Value):
		is_toggled = Value
		button_toggled.emit(Spell_Color, Value)

var modulate_color : Color

func _ready() -> void:
	pressed.connect(_on_button_toggled)
	get_color()

func _on_button_toggled():
	is_toggled = !is_toggled
	self.modulate = modulate_color if is_toggled else Color(1,1,1)

func get_color():
	match Spell_Color:
		GlobalSpells.SpellColor.RED:
			modulate_color = Color(1, 0, 0)
		GlobalSpells.SpellColor.BLUE:
			modulate_color = Color(0, 0, 1)
		GlobalSpells.SpellColor.YELLOW:
			modulate_color = Color(1, 1, 0)
		GlobalSpells.SpellColor.GREEN:
			modulate_color = Color(0, 1, 0)
		_:
			modulate_color = Color(1, 1, 1)
