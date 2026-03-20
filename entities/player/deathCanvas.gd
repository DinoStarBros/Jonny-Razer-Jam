extends CanvasLayer

func _process(delta: float) -> void:
	visible = (get_tree().paused and
		Global.current_game_state == Global.game_states.DEAD
		)
