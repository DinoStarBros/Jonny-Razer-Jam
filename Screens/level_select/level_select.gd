extends Control

@onready var button_and_level : Dictionary = {
	"L1": [
		%l1, 
		func():
		SceneManager.change_scene(References.world_1_lvl)
		Global.current_level_idx = 0
		],
	"L2": [
		%l2, 
		func():
		SceneManager.change_scene(References.world_1_lvl)
		Global.current_level_idx = 1
		],
	"L3": [
		%l3, 
		func():
		SceneManager.change_scene(References.world_1_lvl)
		Global.current_level_idx = 2
		],
	"L4": [
		%l4, 
		func():
		SceneManager.change_scene(References.world_1_lvl)
		Global.current_level_idx = 3
		],
	"L5": [
		%l5, 
		func():
		SceneManager.change_scene(References.world_1_lvl)
		Global.current_level_idx = 4
		],
	"L6": [
		%l6, 
		func():
		SceneManager.change_scene(References.world_1_lvl)
		Global.current_level_idx = 5
		],
	"L7": [
		%l7, 
		func():
		SceneManager.change_scene(References.world_1_lvl)
		Global.current_level_idx = 6
		],
	"L8": [
		%l8, 
		func():
		SceneManager.change_scene(References.world_1_lvl)
		Global.current_level_idx = 7
		],
	"L9": [
		%l9, 
		func():
		SceneManager.change_scene(References.world_1_lvl)
		Global.current_level_idx = 8
		],
	"L10": [
		%l10, 
		func():
		SceneManager.change_scene(References.world_1_lvl)
		Global.current_level_idx = 9
		],
}

func _ready() -> void:
	
	Global.current_game_state = Global.game_states.TITLE
	
	MusicManager.play_song("title")
	for n in button_and_level.values(): if n[0] is Button:
		n[0].pressed.connect(n[1])
	
	%Quit.pressed.connect(func():
		SceneManager.change_scene("res://Screens/title_screen/title_screen.tscn")
		)
