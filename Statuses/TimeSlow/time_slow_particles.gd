extends Status
class_name TimeSlowStatus

func _ready() -> void:
	_setup_timer()
	
	Global.defend_box_speed_multiplier -= time_slow_mult

func _exit_tree() -> void:
	Global.defend_box_speed_multiplier += time_slow_mult
