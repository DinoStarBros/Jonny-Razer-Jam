extends EntityComponentClass
## Component that handles enemies taking debuffs and stuff
class_name EnemyDebuffsComponent

@export var health_component : HealthComponent

enum Debuffs {
	POISON, BURN, ICE, TIME_SLOW
}

const debuffs_dict : Dictionary = {
	Debuffs.POISON: preload("res://Debuffs/Poison/poison.tscn"),
	Debuffs.BURN: preload("res://Debuffs/Burn/burn.tscn"),
	Debuffs.ICE: preload("res://Debuffs/Ice/ice.tscn"),
	Debuffs.TIME_SLOW: preload("res://Debuffs/TimeSlow/time_slow.tscn"),
}

func _init() -> void:
	GlobalSignals.DebuffEnemy.connect(apply_debuff_enemy)

func _ready() -> void:
	pass

func apply_debuff_enemy(debuff:Debuffs, duration:float=1.0) -> void:
	var db : Debuff = debuffs_dict[debuff].instantiate()
	db.health_component = health_component
	db.duration = duration
	add_child(db)

func _process(delta: float) -> void:
	pass
