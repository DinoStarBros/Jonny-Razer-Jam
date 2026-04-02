extends Upgrade
class_name CritChance

func _ready() -> void:
	Global.player_crit_chance = scaling(get_scaling_value(CritChance), 1, true) * stat_upgrades.box_decider.stats.crit_chance
