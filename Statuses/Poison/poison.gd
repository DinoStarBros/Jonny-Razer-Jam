extends Status
class_name PoisonStatus

func _ready() -> void:
	_setup_timer()
	
	%TickTimer.start(tick_duration)
	%TickTimer.timeout.connect(_tick)

func _tick() -> void:
	health_component.hp -= roundi(poison_dmg_tick)
