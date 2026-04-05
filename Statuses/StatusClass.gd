extends Node2D
class_name Status

@export var timer : StatusDurationTimer 

var duration : float = 1
var health_component : HealthComponent

const burn_dmg_tick : float = 2
const tick_duration : float = 0.2
const poison_dmg_tick : float = 1
const ice_slow_mult : float = 0.2
const time_slow_mult : float = 0.4
const energy_up_mult : float = 0.3

func _setup_timer() -> void:
	timer.start(duration)
	timer.timeout.connect(queue_free)
