extends Upgrade
class_name AttackDamage

func _ready() -> void:
	stat_upgrades.box_decider.final_damage += 5
