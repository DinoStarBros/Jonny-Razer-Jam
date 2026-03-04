extends Control
class_name TitleScreen

func _ready() -> void:
	%play.pressed.connect(_play_pressed)
	%settings.pressed.connect(_settings_pressed)
	%quit.pressed.connect(_quit_pressed)
	

func _play_pressed() -> void:
	pass

func _settings_pressed() -> void:
	pass

func _quit_pressed() -> void:
	get_tree().quit()
