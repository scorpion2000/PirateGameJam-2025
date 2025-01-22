extends Node

class_name SpellCondition

enum SpellColor {RED, BLUEE, GREEN, YELLOW}
enum SpellStatus {ON, OFF, SWITCH}

var color: SpellColor
var status: SpellStatus

@warning_ignore("INT_AS_ENUM_WITHOUT_CAST")
func _init(_color: int, _status: int) -> void:
	self.color = _color
	self.status = _status
