extends ItemEffect
class_name CroakDonaldsFX

var duration: float = 1.4

func _ready() -> void:
	item_duration_timer.start(duration)

func heal() -> void:
	GlobalSignals.HealPlayerPercent.emit(0.3)
