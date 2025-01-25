extends Button
class_name RewardCard

signal card_pressed(spell: Spell)

@onready var type_label: Label = %Type
@onready var description_label: Label = %Description
@onready var texture_rect: TextureRect = %TextureRect

var card_spell: Spell

func _enter_tree() -> void:
	pressed.connect(_on_pressed)

func set_card(spell: Spell, type: String, description: String, texture: Texture2D):
	card_spell = spell
	type_label.text = type
	description_label.text = description
	texture_rect.texture = texture

func _on_pressed() -> void:
	card_pressed.emit(card_spell)
