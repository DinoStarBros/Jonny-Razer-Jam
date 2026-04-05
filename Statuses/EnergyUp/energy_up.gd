extends Status
class_name EnergyUpStatus

func _ready() -> void:
	_setup_timer()
	
	Global.product_box_spawn_speed_multiplier += energy_up_mult

func _exit_tree() -> void:
	Global.product_box_spawn_speed_multiplier -= energy_up_mult
