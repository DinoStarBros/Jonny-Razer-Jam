extends EntityComponentClass
## Component that handles enemies taking debuffs and stuff
class_name StatusComponent

@export var health_component : HealthComponent

enum Statuses {
	POISON, BURN, ICE, TIME_SLOW, ENERGY_UP
}

const statuses_dict : Dictionary = {
	Statuses.POISON: preload("res://Statuses/Poison/poison.tscn"),
	Statuses.BURN: preload("res://Statuses/Burn/burn.tscn"),
	Statuses.ICE: preload("res://Statuses/Ice/ice.tscn"),
	Statuses.TIME_SLOW: preload("res://Statuses/TimeSlow/time_slow.tscn"),
	Statuses.ENERGY_UP: preload("res://Statuses/EnergyUp/energy_up.tscn")
}

func _init() -> void: 
	GlobalSignals.GiveStatusEnemy.connect(apply_debuff_enemy)
	GlobalSignals.GiveStatusPlayer.connect(apply_debuff_player)

func _ready() -> void:
	pass

func apply_debuff_enemy(debuff:Statuses, duration:float=1.0) -> void:
	if not get_parent() is Player:
		var db : Status = statuses_dict[debuff].instantiate()
		db.health_component = health_component
		db.duration = duration
		add_child(db)

func apply_debuff_player(debuff:Statuses, duration:float=1.0) -> void:
	if get_parent() is Player:
		var db : Status = statuses_dict[debuff].instantiate()
		db.health_component = health_component
		db.duration = duration
		add_child(db)

func _process(delta: float) -> void:
	pass
