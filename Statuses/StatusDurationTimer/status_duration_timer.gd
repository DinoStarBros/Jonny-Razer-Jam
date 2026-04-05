extends Timer
class_name StatusDurationTimer

func _init() -> void:
	GlobalSignals.GameStateChanged.connect(_game_state_changed)

func _game_state_changed() -> void:
	#if Global.current_game_state == Global.game_states.FIGHT:
		#paused = false
	#else:
		#paused = true
	
	paused = (
		Global.current_game_state != Global.game_states.FIGHT
	)
