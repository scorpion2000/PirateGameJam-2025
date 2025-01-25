extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	
	print(GlobalSpells.get_expected_result([GlobalSpells.spells[0], GlobalSpells.spells[1], GlobalSpells.spells[2]]))
	
	$EnemyCycler._DEBUG_fill_array()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
