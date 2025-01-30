extends Button
class_name RewardCard

@onready var spell_label: Label = %Spell
@onready var stat_upgrade: Label = %StatUpgrade
@onready var condition: HBoxContainer = %Condition

enum RewardType { DAMAGE, HEAL, MAX_HP, SPELL_SIZE}
var card_type: RewardType
var spell_reward
var card_stat: int = 0


func _enter_tree() -> void:
	pressed.connect(_on_pressed)

func setup_card(spell: Spell, type: RewardType):
	spell_reward = spell
	card_type = type
	spell_label.text = "New Magic Word\n%s" % spell.word
	self.visible = true
	
	match card_type:
		RewardType.DAMAGE:
			stat_upgrade.text = "Damage +2\nCurrently: %s" % PlayerData.base_attack
		RewardType.HEAL:
			stat_upgrade.text = "Heal 10\nCurrently: %s" % PlayerData.player.health
		RewardType.MAX_HP:
			stat_upgrade.text = "Max Health +5\nCurrently: %s" % PlayerData.base_health
		RewardType.SPELL_SIZE:
			stat_upgrade.text = "Spell size -1\nCurrently: %s" % PlayerData.spell_size
	
	for i in spell.conditions:
		match i.color:
			GlobalSpells.SpellColor.RED:
				condition.get_child(0).visible = true
				condition.get_child(0).current_mark = i.status
			GlobalSpells.SpellColor.BLUE:
				condition.get_child(1).visible = true
				condition.get_child(1).current_mark = i.status
			GlobalSpells.SpellColor.GREEN:
				condition.get_child(2).visible = true
				condition.get_child(2).current_mark = i.status
			GlobalSpells.SpellColor.YELLOW:
				condition.get_child(3).visible = true
				condition.get_child(3).current_mark = i.status

func _on_pressed() -> void:

	var spell_index = PlayerData.spell_pool.find(spell_reward)
	if spell_index != -1:
		PlayerData.add_spell(spell_index)
	
	match card_type:
		RewardType.DAMAGE:
			PlayerData.base_attack += 2
		RewardType.HEAL:
			PlayerData.player.health += 10
		RewardType.MAX_HP:
			var health_percentage = float(PlayerData.player.health / PlayerData.base_health)
			PlayerData.player.max_health = roundi(PlayerData.base_health * health_percentage)
			PlayerData.base_health = roundi(PlayerData.base_health * health_percentage)
		RewardType.SPELL_SIZE:
			PlayerData.spell_size = clampi(PlayerData.spell_size - 1, 2, 999999)
			
