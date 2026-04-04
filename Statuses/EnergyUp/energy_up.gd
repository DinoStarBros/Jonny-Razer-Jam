extends Status
class_name EnergyUpStatus

func _ready() -> void:
	%Timer.start(duration)
	%Timer.timeout.connect(queue_free)
	
	Global.product_box_spawn_speed_multiplier += energy_up_mult

func _exit_tree() -> void:
	Global.product_box_spawn_speed_multiplier -= energy_up_mult
