extends Upgrade
class_name AttackDamage

func _ready() -> void:
	
	stat_upgrades.box_decider.final_damage = scaling(get_scaling_value(AttackDamage), 3, true) * stat_upgrades.box_decider.stats.damage
