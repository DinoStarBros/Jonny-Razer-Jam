extends Debuff
class_name BurnDebuff

func _ready() -> void:
	%Timer.start(duration)
	%Timer.timeout.connect(queue_free)
	
	%TickTimer.start(tick_duration)
	%TickTimer.timeout.connect(_tick)

func _tick() -> void:
	health_component.hp -= roundi(poison_dmg_tick)
