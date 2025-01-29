extends Control
class_name EnemyStatDisplay

var linked_enemy: Enemy = null

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var health: Label = $ProgressBar/Health
@onready var attack: Label = $Attack
@onready var timer: Label = $Timer
@onready var timerAnimation: AnimationPlayer = $AnimationPlayer


func _process(delta: float) -> void:
	if linked_enemy:
		position = linked_enemy.get_global_transform_with_canvas().origin
		
