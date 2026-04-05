extends Status
class_name IceStatus

func _ready() -> void:
	_setup_timer()
	
	Global.defend_box_speed_multiplier -= ice_slow_mult

func _exit_tree() -> void:
	Global.defend_box_speed_multiplier += ice_slow_mult
