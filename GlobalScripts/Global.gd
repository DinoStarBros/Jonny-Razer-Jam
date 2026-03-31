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

## The maximum amount of boxes that can be on screen 
const MAX_BOXES : int = 25
## The time you need to wait for next combat
const WAIT_TIME : float = 1.5
## The position of the enemy in combat
const ESPAWN_POS : Vector2 = Vector2(960, 360)

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
