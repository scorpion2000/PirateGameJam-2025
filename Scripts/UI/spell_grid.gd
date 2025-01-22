@tool
extends FullGrid

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint(): return
	
	for child in get_children():
		if child is ToggleButton:
			var button : ToggleButton = child as ToggleButton
			button.button_toggled.connect(toggle_buttons)

func toggle_buttons(_color : GlobalSpells.SpellColor, value : bool):
	print(value)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func check_cast_conditions() -> void:
	GlobalSpells.get_spell_result(GlobalSpells.spells[1])
