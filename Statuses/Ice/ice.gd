extends Status
class_name IceStatus

func _ready() -> void:
	%Timer.start(duration)
	%Timer.timeout.connect(queue_free)
	
	Global.defend_box_speed_multiplier -= ice_slow_mult

func _exit_tree() -> void:
	Global.defend_box_speed_multiplier += ice_slow_mult
