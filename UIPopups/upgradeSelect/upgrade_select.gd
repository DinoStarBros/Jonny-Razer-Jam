extends Control
## UI popup that appears when you win a fight, allows you to select
## A stat to buff
class_name UpgradeSelect

var upgrades : Array

func _choose_upgrade_done() -> void:
	GlobalSignals.UpgradeDone.emit()
	%anim.play("exit")

func _upg1_press() -> void:
	_choose_upgrade_done()

func _upg2_press() -> void:
	_choose_upgrade_done()

func _upg3_press() -> void:
	_choose_upgrade_done()

func _ready() -> void:
	%upg1.pressed.connect(_upg1_press)
	%upg2.pressed.connect(_upg2_press)
	%upg3.pressed.connect(_upg3_press)
