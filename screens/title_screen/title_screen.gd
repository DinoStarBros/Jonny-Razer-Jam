extends Control
class_name TitleScreen

func _ready() -> void:
	Global.current_game_state = Global.game_states.TITLE
	%play.pressed.connect(_play_pressed)
	%settings.pressed.connect(_settings_pressed)
	%credits.pressed.connect(_credits_pressed)
	%quit.pressed.connect(_quit_pressed)
	%close.pressed.connect(_close_pressed)
	MusicManager.play_song("title")

func _play_pressed() -> void:
	SceneManager.change_scene("res://Screens/level_select/level_select.tscn")

func _settings_pressed() -> void:
	%settingsMenu.visible = !%settingsMenu.visible

func _credits_pressed() -> void:
	%credits_panel.visible = !%credits_panel.visible

func _quit_pressed() -> void:
	get_tree().quit()
	SaveLoad.save_everything()

func _close_pressed() -> void:
	_settings_pressed()
	%settingsMenu._on_save_pressed()
