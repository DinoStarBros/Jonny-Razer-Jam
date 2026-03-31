extends Upgrade
class_name AttackDamage

func _ready() -> void:
	stat_upgrades.box_decider.final_damage *= scaling(1, 5, true)
