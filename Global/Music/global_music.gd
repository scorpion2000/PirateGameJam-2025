extends Node

enum GamePhase {MENU, COMBAT, CARDS}

var current_phase: GamePhase = GamePhase.MENU
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	switch_music(GamePhase.MENU)


func switch_music(phase: GamePhase):
	
	current_phase = phase
	
	audio.stream.set_sync_stream_volume(phase, 12)
	
	if phase != GamePhase.MENU:
		audio.stream.set_sync_stream_volume(GamePhase.MENU, -60)
	
	if phase != GamePhase.COMBAT:
		audio.stream.set_sync_stream_volume(GamePhase.COMBAT, -60)
	
	if phase != GamePhase.CARDS:
		audio.stream.set_sync_stream_volume(GamePhase.CARDS, -60)
