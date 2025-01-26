extends Node

@onready var masterSlider: HSlider = $Control/HSlider
@onready var musicSlider: HSlider = $Control/HSlider2
@onready var effectSlider: HSlider = $Control/HSlider3
@onready var toggleButton: Button = $Button
@onready var settings: Control = $Control

func _ready():
	toggleButton.connect("pressed", _toggleSettings)

	masterSlider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	musicSlider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	effectSlider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))

	masterSlider.connect("value_changed", _changeMaster)
	musicSlider.connect("value_changed", _changeMusic)
	effectSlider.connect("value_changed", _changeEffect)

func _changeMaster(value):
	print(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value if value > -30 else -80)

func _changeMusic(value):
	print(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value if value > -30 else -80)

func _changeEffect(value):
	print(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value if value > -30 else -80)

func _toggleSettings():
	settings.visible = !settings.visible