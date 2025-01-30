extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	PlayerData.setup_new_player_data()
	
	GameManager.entity_stats_holder = $CanvasLayer/EntityStatsDisplay
	GlobalMusic.switch_music(GlobalMusic.GamePhase.COMBAT)
	
	await get_tree().process_frame
	
	
	print(GlobalSpells.get_expected_result([GlobalSpells.spells[0], GlobalSpells.spells[1], GlobalSpells.spells[2]]))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
