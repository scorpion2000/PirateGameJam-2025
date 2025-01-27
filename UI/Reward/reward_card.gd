extends Button
class_name RewardCard

@onready var type_label: Label = %Type
@onready var name_label: Label = %Name
@onready var texture_rect: TextureRect = %TextureRect

enum RewardType { SPELL, STATS }
var card_type: RewardType
var card_reward
var card_stat: int = 0

func _enter_tree() -> void:
	pressed.connect(_on_pressed)

func setup_card(reward_name: String, type: RewardType, reward: Variant):
	card_type = type
	type_label.text = "Word"
	name_label.text = reward_name
	card_reward = reward
	self.visible = true
	
	match card_type:
		RewardType.SPELL:
			type_label.text = "New Word:"
		RewardType.STATS:
			type_label.text = "Stats"

func _on_pressed() -> void:
	match card_type:
		RewardType.SPELL:
			var spell : Spell = card_reward as Spell
			var spell_index = PlayerData.spell_pool.find(spell)
			if spell_index != -1:
				PlayerData.add_spell(spell_index)
			
			for spellx in PlayerData.spells:
				print(spellx.word)
		RewardType.STATS:
			var player = get_tree().get_first_node_in_group("Player") as Player
			player.health += card_reward as float
			print(player.health)
			if player.health > 100:
				player.health = 100
