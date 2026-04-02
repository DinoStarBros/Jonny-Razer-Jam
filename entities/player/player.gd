extends Node2D
class_name Player

@export var health_component: HealthComponent

#@onready var health_component: HealthComponent = %HealthComponent
@onready var box_decider: BoxDecider = %BoxDecider
@onready var ui: CanvasLayer = %ui
@onready var anim: AnimationPlayer = %anim

var died : bool = false ## A one time thingy

func _ready() -> void:
	GlobalSignals.DamagePlayer.connect(hurt)
	GlobalSignals.DamageEnemy.connect(hit_enemy)
	GlobalSignals.FightWin.connect(fight_win)
	GlobalSignals.UpgradeDone.connect(_upgrade_done)
	GlobalSignals.CombatStart.connect(_combat_done)
	GlobalSignals.Defended.connect(_defended)
	GlobalSignals.HealPlayerPercent.connect(_heal_player_percent)

func _process(delta: float) -> void:
	pass

func hurt(damage: float) -> void:
	anim.stop()
	anim.play("take_damage")

func hit_enemy(damage: float) -> void:
	if not Global.current_game_state == Global.game_states.FIGHT:
		return
	
	anim.stop()
	anim.play("attack")

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

func _heal_player_percent(percent: float) -> void:
	var heal_amount : float = (health_component.max_hp * percent)
	
	health_component.hp += roundi(heal_amount)
