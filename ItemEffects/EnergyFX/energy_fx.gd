extends ItemEffect
class_name EnergyFX

func _ready() -> void:
	GlobalSignals.GiveStatusPlayer.emit(
		StatusComponent.Statuses.ENERGY_UP,
		1
	)
