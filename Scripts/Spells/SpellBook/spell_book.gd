extends TextureRect

class_name SpellBook

@onready var spell_example: HBoxContainer = $SpellGuide/SpellExample

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func add_spell(spell: Spell):
	var new_spell: HBoxContainer = spell_example.duplicate()
	new_spell.name = spell.word
	new_spell.SpellName.text = spell.word
	
	for i in spell.conditions:
		match i.color:
			0:
				new_spell.Red.visible = true
				new_spell.Red.current_mark = i.status
			1:
				new_spell.Blue.visible = true
				new_spell.Blue.current_mark = i.status
			2:
				new_spell.Green.visible = true
				new_spell.Green.current_mark = i.status
			3:
				new_spell.Yellow.visible = true
				new_spell.Yellow.current_mark = i.status
