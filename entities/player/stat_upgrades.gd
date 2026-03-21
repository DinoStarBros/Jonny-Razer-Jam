extends Node
## The parent for the stat upgrade nodes
class_name StatUpgrades

func _ready() -> void:
	GlobalSignals.AddUpgrade.connect(_add_upgrade)

func _add_upgrade(upgrade_scn : PackedScene) -> void:
	var upgrade : TextureRect = upgrade_scn.instantiate()
	%upgrade_icons.add_child(upgrade)
