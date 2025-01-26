extends RigidBody2D
class_name DamageIndicator

var label : Label = Label.new()
var timer : Timer = Timer.new()
var damage : int = 0

func _ready():
	gravity_scale = 2
	add_child(label)
	add_child(timer)
	label.text = str(-damage)
	apply_impulse(Vector2(randf_range(-100, 100), -600))
	timer.start(2)
	timer.timeout.connect(queue_free)
