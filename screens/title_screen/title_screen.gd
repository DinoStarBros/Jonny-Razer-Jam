extends Control
class_name TitleScreen

@export_range(1,3) var prototype_id : int = 1

func _ready() -> void:
	%play.pressed.connect(_play_pressed)
	%settings.pressed.connect(_settings_pressed)
	%quit.pressed.connect(_quit_pressed)

func _play_pressed() -> void:
	match prototype_id:
		1:
			SceneManager.change_scene("res://Screens/prototype_1/combo_knight_like_proto.tscn")

func _settings_pressed() -> void:
	pass

func _quit_pressed() -> void:
	get_tree().quit()
