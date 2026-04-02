extends EntityComponentClass
## Component that allocates the stats from the Stats resource to
## its corresponding Components
## Also acts like a checklist for the components needed for
## an entity
class_name StatsAllocator

@export var stats : EntityStats

@export var health_component : HealthComponent
@export var box_decider : BoxDecider

func _ready() -> void:
	
	await get_tree().process_frame
	
	#if get_parent() is Enemy:
		#stats.max_hp *= enemy_idx + 1
		#
		#stats.spawn_amount_range *= enemy_idx + 1
		#stats.spawn_time_range *= enemy_idx + 1
		#stats.box_speed_range *= enemy_idx + 1
		#stats.damage *= enemy_idx + 1
	
	health_component.stats = stats
	box_decider.stats = stats
	
