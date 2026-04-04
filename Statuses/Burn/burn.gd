extends Status
class_name BurnStatus

func _ready() -> void:
	%Timer.start(duration)
	%Timer.timeout.connect(queue_free)
	
	%TickTimer.start(tick_duration)
	%TickTimer.timeout.connect(_tick)

func _tick() -> void:
	health_component.hp -= roundi(burn_dmg_tick)
