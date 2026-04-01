extends Upgrade
class_name AttackDamage

var scaling_val : float = 1

func _ready() -> void:
	scaling_val = get_parent().get_child_count()
	
	stat_upgrades.box_decider.final_damage = scaling(scaling_val, 3, true) * stat_upgrades.box_decider.stats.damage
