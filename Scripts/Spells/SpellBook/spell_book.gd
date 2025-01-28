extends TextureRect

class_name SpellBook

var is_open: bool = false

const spell_example = preload("res://Scripts/Spells/SpellBook/spell_example.tscn")
@onready var spell_guide: VBoxContainer = $SpellGuide

func _ready() -> void:
	PlayerData.spell_book = self


func add_spell(spell: Spell):
	var new_spell: HBoxContainer = spell_example.instantiate()
	spell_guide.add_child(new_spell)
	new_spell.name = spell.word
	new_spell.get_child(0).text = spell.word
	
	for i in spell.conditions:
		match i.color:
			GlobalSpells.SpellColor.RED:
				new_spell.get_child(1).visible = true
				new_spell.get_child(1).current_mark = i.status
			GlobalSpells.SpellColor.BLUE:
				new_spell.get_child(2).visible = true
				new_spell.get_child(2).current_mark = i.status
			GlobalSpells.SpellColor.GREEN:
				new_spell.get_child(3).visible = true
				new_spell.get_child(3).current_mark = i.status
			GlobalSpells.SpellColor.YELLOW:
				new_spell.get_child(4).visible = true
				new_spell.get_child(4).current_mark = i.status
	new_spell.visible = true


func set_open():
	is_open = !is_open
	
	if is_open:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(248, 115), 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	else:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(248, 676), 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)


func _on_close_button_down() -> void:
	set_open()
