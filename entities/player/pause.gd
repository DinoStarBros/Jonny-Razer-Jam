extends CanvasLayer

@onready var settings_menu: Settings = %settingsMenu

var sure_quit : bool = false

func _ready() -> void:
	%resume.pressed.connect(on_resume)
	%quit.pressed.connect(func():sure_quit=!sure_quit)
	%sure.pressed.connect(func():
		get_tree().paused = false
		SceneManager.change_scene("res://Screens/level_select/level_select.tscn")
		%settingsMenu._on_save_pressed()
		)



func _input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("esc") and 
		Global.current_game_state == Global.game_states.FIGHT
		):
		get_tree().paused = not get_tree().paused
		if get_tree().paused:
			# Pause
			settings_menu.on_pause()
		else:
			# Resume
			settings_menu.on_resume()

func _process(delta: float) -> void:
	visible = (get_tree().paused and
		Global.current_game_state == Global.game_states.FIGHT
		)

func on_resume() -> void:
	get_tree().paused=false
	%settingsMenu._on_save_pressed()
