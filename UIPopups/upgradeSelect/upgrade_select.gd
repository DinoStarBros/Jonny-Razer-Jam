extends Control
## UI popup that appears when you win a fight, allows you to select
## A stat to buff
class_name UpgradeSelect

@onready var panel: PanelContainer = %panel

var panel_desire_pos_y : float
var upgrades : Array

func _choose_upgrade_done() -> void:
	GlobalSignals.UpgradeDone.emit()
	panel_desire_pos_y = 800
	for button in %buttons.get_children(): if button is Button:
		button.disabled = true
	%deleTimer.start(0.5)

func _upg1_press() -> void:
	_choose_upgrade_done()
	GlobalSignals.AddUpgrade.emit(StatUpgrades.upgrades_enum.HEALTH)

func _upg2_press() -> void:
	_choose_upgrade_done()
	GlobalSignals.AddUpgrade.emit(StatUpgrades.upgrades_enum.ATTACK_DAMAGE)

func _upg3_press() -> void:
	_choose_upgrade_done()
	GlobalSignals.AddUpgrade.emit(StatUpgrades.upgrades_enum.CRIT_CHANCE)

func _ready() -> void:
	%upg1.pressed.connect(_upg1_press)
	%upg2.pressed.connect(_upg2_press)
	%upg3.pressed.connect(_upg3_press)
	%deleTimer.timeout.connect(func(): queue_free())
	
	panel_desire_pos_y = 180

func _physics_process(delta: float) -> void:
	panel.global_position.y = lerp(panel.global_position.y, panel_desire_pos_y, 8.0 * delta)
