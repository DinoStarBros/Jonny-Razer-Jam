extends Timer
class_name StatusDurationTimer

func _init() -> void:
	GlobalSignals.GameStateChanged.connect(_game_state_changed)

func _game_state_changed() -> void:
	
	paused = (
		Global.current_game_state != Global.game_states.FIGHT
	)
	
	if paused:
		get_parent().process_mode = Node.PROCESS_MODE_DISABLED
	else:
		get_parent().process_mode = Node.PROCESS_MODE_INHERIT
