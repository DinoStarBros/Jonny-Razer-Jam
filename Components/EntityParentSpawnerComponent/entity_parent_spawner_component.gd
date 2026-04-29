extends Node2D
## Handles spawning enemies/entities
## Also the transition from combat to combat
## After you picked an upgrade
class_name EntityParentSpawnerComponent

@export var level_resource : LevelResource

var curr_enemies_defeated: int = -1

func _init() -> void:
	match Global.current_world_idx:
		0: # World 1
			level_resource = References.world1_levels_res[Global.current_level_idx]
		_: # Just load world 1 I guess lmao
			level_resource = References.world1_levels_res[Global.current_level_idx]

func _ready() -> void:
	
	Global.enemy_idx = curr_enemies_defeated
	Global.entity_parent_spawner_comp = self
	Global.boss_spawned = false
	
	GlobalSignals.UpgradeDone.connect(_upgrade_done)
	GlobalSignals.CombatStart.connect(_combat_start)
	GlobalSignals.FightWin.connect(_fight_win)
	
	MusicManager.play_song("combat1")
	
	await get_tree().process_frame
	GlobalSignals.UpgradeDone.emit()

func _upgrade_done() -> void:
	
	curr_enemies_defeated += 1
	Global.enemy_idx = curr_enemies_defeated
	_spawn_ene_defeated_popup(curr_enemies_defeated, level_resource.enemy_amount)
	
	Global.current_game_state = Global.game_states.TRANSITION_NEXT_COMBAT
	
	#await get_tree().create_timer(0).timeout
	await get_tree().create_timer(Global.WAIT_TIME + randf_range(-0.2, 0.5)).timeout
	
	Global.current_game_state = Global.game_states.FIGHT
	GlobalSignals.CombatStart.emit()

func _combat_start() -> void:
	if curr_enemies_defeated < level_resource.enemy_amount - 1:
		_spawn_enemy()
	else:
		_spawn_boss()

func _spawn_enemy() -> void:
	var enemy : Enemy = level_resource.enemy_scns.pick_random().instantiate()
	add_child(enemy)
	enemy.stat_headstart = level_resource.inherent_stat_headstart
	enemy.global_position = Global.ESPAWN_POS

func _spawn_boss() -> void:
	Global.boss_spawned = true
	_boss_music()
	
	var boss : Enemy = level_resource.boss_scns.pick_random().instantiate()
	boss.stat_headstart = level_resource.inherent_stat_headstart
	add_child(boss)
	boss.global_position = Global.ESPAWN_POS

func _spawn_ene_defeated_popup(enemies_defeated: int, max_enemies: int) -> void:
	var enemies_defeated_popup : EnemiesDefeatedPopup = References.enemies_def_scn.instantiate()
	enemies_defeated_popup.enemies = enemies_defeated
	enemies_defeated_popup.max_enemies = max_enemies
	add_child(enemies_defeated_popup)

func _fight_win() -> void:
	pass

func _boss_music() -> void:
	match Global.current_world_idx:
		0:
			MusicManager.play_song("boss3")
		_:
			MusicManager.play_song("boss3")
