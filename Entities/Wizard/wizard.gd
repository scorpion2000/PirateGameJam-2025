extends Node

@export var intensity: float = 1.0
@export var duration: float = 0.8
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	trigger_flash()

func trigger_flash():
	var player_shader = self.material
	var time = 0.0
	while time < duration:
		var current_intensity = sin((PI * time) / duration) * intensity
		player_shader.set_shader_parameter("flash_amount", current_intensity)
		time += get_process_delta_time()
		await get_tree().process_frame
	player_shader.set_shader_parameter("flash_amount", 0.0)


func _cast_result(result: bool) -> void:
	if !result: trigger_flash()


func animate(animation: String):
	animation_player.play(animation)
