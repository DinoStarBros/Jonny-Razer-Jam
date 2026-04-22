extends EntityComponentClass
## Component that allocates the stats from the Stats resource to
## its corresponding Components
## Also acts like a checklist for the components needed for
## an entity
class_name StatsAllocator

@export var stats : BaseEntityStats

@export_category("The Entity Components")
@export var health_component : HealthComponent
@export var box_decider : BoxDecider
@export var combat_signals : CombatSignalsHandler ## Just here for attendance lol

func _ready() -> void:
	
	await get_tree().process_frame
	
	health_component.stats = stats
	box_decider.stats = stats
