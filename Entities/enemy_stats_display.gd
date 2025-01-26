extends Control
class_name EnemyStatDisplay

var linked_enemy: Enemy = null

@onready var health: Label = $Health
@onready var attack: Label = $Attack


func _process(delta: float) -> void:
	if linked_enemy:
		position = linked_enemy.get_global_transform_with_canvas().origin
		
