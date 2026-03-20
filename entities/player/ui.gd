extends CanvasLayer

var upgrade_select_scn : PackedScene = load("res://UIPopups/upgradeSelect/upgrade_select.tscn")

func _ready() -> void:
	GlobalSignals.FightWin.connect(fight_win)

func fight_win() -> void:
	var upgrade_select : UpgradeSelect = upgrade_select_scn.instantiate()
	add_child(upgrade_select)
