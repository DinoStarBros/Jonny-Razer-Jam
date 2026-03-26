extends Node
## The parent for the stat upgrade nodes
class_name StatUpgrades

@onready var box_decider: BoxDecider = %BoxDecider
@onready var health_component: HealthComponent = %HealthComponent

func _ready() -> void:
	GlobalSignals.AddUpgrade.connect(_add_upgrade)

func _add_upgrade(upgrade_scn : PackedScene) -> void:
	var upgrade : TextureRect = upgrade_scn.instantiate()
	%upgrade_icons.add_child(upgrade)
