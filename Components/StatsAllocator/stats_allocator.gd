extends Node
## Component that allocates the stats from the Stats resource to
## its corresponding Components
## Also acts like a checklist for the components needed for
## an entity
class_name StatsAllocator

@export var stats : EntityStats

@export var health_component : HealthComponent
@export var box_decider : BoxDecider

func _ready() -> void:
	
	health_component.stats = stats
	box_decider.stats = stats
