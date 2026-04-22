extends Control

@onready var button_and_level : Dictionary = {
	"L1": [
		%l1, 
		func():SceneManager.change_scene(References.levels_arr[0])
		],
	"L2": [
		%l2, 
		func():SceneManager.change_scene(References.levels_arr[1])
		],
	"L3": [
		%l3, 
		func():print("3")
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
