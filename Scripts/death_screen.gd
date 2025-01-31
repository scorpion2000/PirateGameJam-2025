extends Panel
class_name DeathScreen

var gameScene : PackedScene = preload("res://Main/spell_test.tscn")

@onready var restartButton : Button = $VBoxContainer/Button

func _ready():
	PlayerData.death.connect(_makeVisible)
	restartButton.pressed.connect(_restart)

func _makeVisible():
	self.show()
	var alpha_tween = create_tween()
	alpha_tween.tween_property(self, "modulate:a", 1, 2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)

func _restart():
	var scene = gameScene.instantiate()
	get_tree().root.add_child(scene)
	get_parent().queue_free()
