extends Node

class_name SpellCondition

enum SpellColor {RED, BLUEE, GREEN, YELLOW}
enum SpellStatus {ON, OFF, SWITCH}

var color: SpellColor
var status: SpellStatus


func _init(_color: int, _status: int) -> void:
	self.color = _color
	self.status = _status
