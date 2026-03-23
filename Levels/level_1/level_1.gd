extends Node2D

@onready var bg_and_speeds : Dictionary = {
	0: [%l1, 2.5],
	1: [%l2, 2],
	2: [%l3, 1.5],
	3: [%l4, 1],
	
}

var move_val : float = 0 ## Switches between 0 and 1

const BG_LAYER_MS : float = -75

func _ready() -> void:
	MusicManager.stop_all_songs()

func _process(delta: float) -> void:
	for i in bg_and_speeds.size():
		bg_and_speeds[i][0].global_position.x += BG_LAYER_MS * bg_and_speeds[i][1] * delta * move_val
	
		bg_and_speeds[i][0].global_position.x = wrapf(bg_and_speeds[i][0].global_position.x, -1280, 0)

	if Global.current_game_state == Global.game_states.TRANSITION_NEXT_COMBAT:
		move_val = 1
	else:
		move_val = 0
