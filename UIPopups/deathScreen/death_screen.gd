extends Control

func _ready() -> void:
	%exit.pressed.connect(exit)

func exit() -> void:
	get_tree().paused = false
	SceneManager.change_scene("res://Screens/level_select/level_select.tscn")
