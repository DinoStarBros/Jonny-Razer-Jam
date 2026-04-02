extends Upgrade
class_name AttackDamage

var siblings : Array

func _ready() -> void:
	siblings = get_parent().get_children()
	
	scaling_val = siblings.size()
	
	stat_upgrades.box_decider.final_damage = scaling(scaling_val, 3, true) * stat_upgrades.box_decider.stats.damage
