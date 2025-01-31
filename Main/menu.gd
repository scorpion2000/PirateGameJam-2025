extends Node2D




func _on_play_button_down() -> void:
	get_tree().change_scene_to_file("res://Main/spell_test.tscn")


func _on_credits_button_down() -> void:
	$CanvasLayer/VBoxContainer.hide()
	$CanvasLayer/Credits.show()


func _on_credit_back_button_down() -> void:
	$CanvasLayer/VBoxContainer.show()
	$CanvasLayer/Credits.hide()


func _on_quit_button_down() -> void:
	get_tree().quit()


func _on_options_button_down() -> void:
	$CanvasLayer/VBoxContainer.hide()
	$CanvasLayer/Control.show()


func _on_options_back_button_down() -> void:
	$CanvasLayer/VBoxContainer.show()
	$CanvasLayer/Control.hide()
