extends CanvasLayer

@onready var pause_ui: PauseUI = %pause
@onready var stats_allocator: StatsAllocator = %StatsAllocator
@onready var box_decider: BoxDecider = %BoxDecider

var upgrade_select_scn : PackedScene = load("res://UIPopups/upgradeSelect/upgrade_select.tscn")

func _ready() -> void:
	GlobalSignals.FightWin.connect(fight_win)
	Global.player_crit_chance = stats_allocator.stats.crit_chance
	%pauseButton.pressed.connect(_pause_pressed)

func fight_win() -> void:
	var upgrade_select : UpgradeSelect = upgrade_select_scn.instantiate()
	add_child(upgrade_select)

func _process(delta: float) -> void:
	%pauseButton.visible = Global.current_game_state == Global.game_states.FIGHT
	_stats_texts()
	
	%debug.text = str(
		Global.product_box_spawn_speed_multiplier
	)
	
	%damage_txt.text = str(
		"Damage: ", roundi(box_decider.final_damage)
	)
	
	%crit_txt.text = str(
		"Critical Chance: ", roundi(Global.player_crit_chance)
	)
	
	%item_eff_txt.text = str(
		"Item Efficiency: ", roundi(Global.item_efficiency)
	)
	
	%luck_txt.text = str(
		"Luck: ", roundi(Global.luck)
	)

func _pause_pressed() -> void:
	pause_ui.pause_or_resume()

func _stats_texts() -> void:
	pass
