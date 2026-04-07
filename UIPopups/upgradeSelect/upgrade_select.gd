extends Control
## UI popup that appears when you win a fight, allows you to select
## A stat to buff
class_name UpgradeSelect

@onready var panel: PanelContainer = %panel

var panel_desire_pos_y : float
var upgrades : Array
var upgrade_ids : Array

#enum upgrades_enum {
	#ITEM_EFFICIENCY, HEALTH, ATTACK_DAMAGE, CRIT_CHANCE, LUCK
#}

## 0-Description, 1-Texture, 2-UpgScene
const ITEM_DATA : Dictionary = {
	0: [
		"Max Health: Increases max hp",
		preload("res://upgrade_icons/health_texture.tres"),
		preload("res://upgrade_icons/health/health.tscn")
	],
	1: [
		"Attack Damage: Increases damage for the boxes",
		preload("res://upgrade_icons/attack_damage_texture.tres"),
		preload("res://upgrade_icons/attack_damage/attack_damage.tscn")
	],
	2: [
		"Crit Chance: Increases chance to do critical attack",
		preload("res://upgrade_icons/crit_chance_texture.tres"),
		preload("res://upgrade_icons/crit_chance/crit_chance.tscn")
	],
	3: [
		"Luck: Increases chance of getting item",
		preload("res://upgrade_icons/luck_texture.tres"),
		preload("res://upgrade_icons/luck/luck.tscn")
	],
	4: [
		"Item Efficiency: Reduces items combo cost by 1 \n
		(max of 3, +5 luck after)",
		preload("res://upgrade_icons/item_eff_texture.tres"),
		preload("res://upgrade_icons/item_efficiency/item_efficiency.tscn")
	],
}

func _choose_upgrade_done() -> void:
	GlobalSignals.UpgradeDone.emit()
	panel_desire_pos_y = 800
	for button in %buttons.get_children(): if button is Button:
		button.disabled = true
	%deleTimer.start(0.5)

func _upg1_press() -> void:
	_choose_upgrade_done()
	GlobalSignals.AddUpgrade.emit(ITEM_DATA[upgrade_ids[0]][2])

func _upg2_press() -> void:
	_choose_upgrade_done()
	GlobalSignals.AddUpgrade.emit(ITEM_DATA[upgrade_ids[1]][2])

func _upg3_press() -> void:
	_choose_upgrade_done()
	GlobalSignals.AddUpgrade.emit(ITEM_DATA[upgrade_ids[2]][2])

func _ready() -> void:
	%upg1.pressed.connect(_upg1_press)
	%upg2.pressed.connect(_upg2_press)
	%upg3.pressed.connect(_upg3_press)
	%deleTimer.timeout.connect(func(): queue_free())
	
	panel_desire_pos_y = 180
	
	
	for item in ITEM_DATA.size():
		upgrade_ids.append(item)
	
	upgrade_ids = [
		4,3, 1,2,0
	]
	
	upgrade_ids.shuffle()
	
	_load_button_text()
	_load_button_textures()

func _physics_process(delta: float) -> void:
	panel.global_position.y = lerp(panel.global_position.y, panel_desire_pos_y, 4.0 * delta)

func _load_button_text() -> void:
	%upg1.text = str(
		"Upgrade 1: \n",
		ITEM_DATA[upgrade_ids[0]][0]
	)
	
	%upg2.text = str(
		"Upgrade 2: \n",
		ITEM_DATA[upgrade_ids[1]][0]
	)
	
	%upg3.text = str(
		"Upgrade 3: \n",
		ITEM_DATA[upgrade_ids[2]][0]
	)

func _load_button_textures() -> void:
	%upg1.icon = ITEM_DATA[upgrade_ids[0]][1]
	%upg2.icon = ITEM_DATA[upgrade_ids[1]][1]
	%upg3.icon = ITEM_DATA[upgrade_ids[2]][1]
