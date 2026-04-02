extends Upgrade
class_name CritChance

func _ready() -> void:
	stat_upgrades.box_decider.final_damage = scaling(get_scaling_value(CritChance), 3, true) * stat_upgrades.box_decider.stats.damage
