extends Node
## The parent for the stat upgrade nodes
class_name StatUpgrades

enum upgrades_enum {
	HEALTH, ATTACK_DAMAGE, CRIT_CHANCE, ITEM_EFFICIENCY, LUCK
}

func _ready() -> void:
	GlobalSignals.AddUpgrade.connect(_add_upgrade)

func _add_upgrade(upgrade : upgrades_enum) -> void:
	print(upgrade)
