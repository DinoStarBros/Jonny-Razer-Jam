extends Node

enum game_states {
	TITLE, FIGHT, DEAD, WIN, UPGRADE, TRANSITION_NEXT_COMBAT, 
	USING_ITEM
}

var current_game_state : game_states
var boxes_amnt : int = 0
var endpoints_x : Vector2
## Index for the current enemy in the level
var enemy_idx : int = -1
var inventory : Inventory
var cursor : Cursor
var item_effects : ItemEffects
var final_damage : float
var defend_box_speed_multiplier: float = 1:  ## Multiplier for how fast defend boxes go from left to right
	set(value):
		defend_box_speed_multiplier = clamp(value, 0, 1)
var player_crit_chance : float
var entity_parent_spawner_comp : EntityParentSpawnerComponent
var camera : Camera

## The maximum amount of boxes that can be on screen 
const MAX_BOXES : int = 25
## The time you need to wait for next combat
const WAIT_TIME : float = 1.5
## The position of the enemy in combat
const ESPAWN_POS : Vector2 = Vector2(960, 360)
## The damage multiplier when you crit
const CRIT_DMG_MULT : float = 2
const txt_scn : PackedScene = preload("res://juices/DmgNum/dmg_num.tscn")

func _volume_handle() -> void:
	AudioServer.set_bus_volume_db(
		0,
		linear_to_db(SaveLoad.settings.master_volume)
	)
	AudioServer.set_bus_volume_db(
		1,
		linear_to_db(SaveLoad.settings.music_volume)
	)
	AudioServer.set_bus_volume_db(
		2,
		linear_to_db(SaveLoad.settings.sfx_volume)
	)

func _init() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	_volume_handle()

func _ready() -> void:
	_volume_handle()

func _process(delta: float) -> void:
	_volume_handle()

func frame_freeze(timescale: float, duration: float) -> void: ## Slows down the engine's time scale, slowing down the time, for a certain duration. Use for da juice
	if SaveLoad.settings.frame_freeze_value:
		Engine.time_scale = timescale
		await get_tree().create_timer(duration, true, false, true).timeout
		Engine.time_scale = 1.0

func spawn_txt(text: String, global_pos: Vector2, color: Color = Color.WHITE)->void: ## Spawns a splash text effect, can be used for damage numbers, or score
	var txt : DmgNum = txt_scn.instantiate()
	txt.text = text
	txt.global_position = global_pos
	txt.modulate = color
	entity_parent_spawner_comp.add_child(txt)
