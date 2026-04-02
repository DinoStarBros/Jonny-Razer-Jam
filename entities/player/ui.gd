extends CanvasLayer

@onready var pause_ui: PauseUI = %pause
@onready var stats_allocator: StatsAllocator = %StatsAllocator

var upgrade_select_scn : PackedScene = load("res://UIPopups/upgradeSelect/upgrade_select.tscn")

func _ready() -> void:
	GlobalSignals.FightWin.connect(fight_win)
	%pauseButton.pressed.connect(_pause_pressed)

func fight_win() -> void:
	var upgrade_select : UpgradeSelect = upgrade_select_scn.instantiate()
	add_child(upgrade_select)

func _process(delta: float) -> void:
	%pauseButton.visible = Global.current_game_state == Global.game_states.FIGHT
	_stats_texts()
	
	%debug.text = str(
		Global.defend_box_speed_multiplier
	)

func _pause_pressed() -> void:
	pause_ui.pause_or_resume()

func _stats_texts() -> void:
	pass
