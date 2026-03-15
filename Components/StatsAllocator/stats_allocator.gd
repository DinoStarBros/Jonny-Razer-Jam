extends Node
## Component that allocates the stats from the Stats resource to
## its corresponding Components
class_name StatsAllocator

@export var stats : EntityStats

@export var health_component : HealthComponent
@export var box_decider : BoxDecider

func _ready() -> void:
	health_component.max_hp = stats.max_hp
	health_component.hp = stats.max_hp
	
	box_decider.random_or_pattern = stats.random_or_pattern
	box_decider.box_scenes = stats.box_scenes
