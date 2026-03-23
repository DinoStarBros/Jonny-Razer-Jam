extends Node2D
## Handles spawning enemies/entities
## Also the transition from combat to combat
## After you picked an upgrade
class_name EntityParentSpawnerComponent

@export var level_resource : LevelResource

func _ready() -> void:
	GlobalSignals.UpgradeDone.connect(_upgrade_done)
	GlobalSignals.CombatStart.connect(_combat_start)

func _upgrade_done() -> void:
	Global.current_game_state = Global.game_states.TRANSITION_NEXT_COMBAT
	await get_tree().create_timer(Global.WAIT_TIME + randf_range(-0.2, 0.5)).timeout
	Global.current_game_state = Global.game_states.FIGHT
	GlobalSignals.CombatStart.emit()

func _combat_start() -> void:
	var enemy = level_resource.enemy_scns.pick_random().instantiate()
	add_child(enemy)
	enemy.global_position = Global.ESPAWN_POS
