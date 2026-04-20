extends Node2D
class_name Player

@export var health_component: HealthComponent

#@onready var health_component: HealthComponent = %HealthComponent
@onready var box_decider: BoxDecider = %BoxDecider
@onready var ui: CanvasLayer = %ui
@onready var anim: AnimationPlayer = %anim
@onready var camera: Camera = %Camera

var died : bool = false ## A one time thingy
#var current

const stats : BaseEntityStats = preload("res://Stats/BasePlayerStats.tres")

func _ready() -> void:
	
	GlobalSignals.DamagePlayer.connect(hurt)
	GlobalSignals.DamageEnemy.connect(hit_enemy)
	GlobalSignals.FightWin.connect(fight_win)
	GlobalSignals.UpgradeDone.connect(_upgrade_done)
	GlobalSignals.CombatStart.connect(_combat_done)
	GlobalSignals.Defended.connect(_defended)
	GlobalSignals.HealPlayerPercent.connect(_heal_player_percent)
	
	Global.item_efficiency = stats.item_efficiency
	Global.luck = stats.luck

func _process(delta: float) -> void:
	pass

func hurt(damage: float) -> void:
	Global.spawn_txt(str(roundi(damage)), global_position)
	
	anim.stop()
	anim.play("take_damage")
	camera.screen_shake(5, 0.2)
	Global.frame_freeze(0.9, 0.1)

func hit_enemy(damage: float, allow_crit: bool) -> void:
	if not Global.current_game_state == Global.game_states.FIGHT:
		return
	
	anim.stop()
	anim.play("attack")
	camera.screen_shake(6, 0.05)

func play_hurt_sfx() -> void:
	%hurt1.pitch_scale = randf_range(0.8, 1.0)
	%hurt1.play()
	%hurt2.pitch_scale = randf_range(0.8, 1.0)
	%hurt2.play()

func fight_win() -> void:
	pass

func play_idle() -> void:
	anim.play("idle")

func _upgrade_done() -> void:
	anim.stop()
	anim.play("walk")

func _combat_done() -> void:
	anim.play("idle")

func _defended() -> void:
	anim.stop()
	anim.play("block")
	camera.screen_shake(5, 0.1)

func _heal_player_percent(percent: float) -> void:
	var heal_amount : float = (health_component.max_hp * percent)
	
	health_component.hp += roundi(heal_amount)
