extends Upgrade
class_name Luck

func _ready() -> void:
	Global.luck = scaling(get_scaling_value(Luck), 2, true) * stat_upgrades.box_decider.stats.luck
