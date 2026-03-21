extends Node2D
class_name Player

#@onready var health_component: HealthComponent = %HealthComponent
@onready var box_decider: BoxDecider = %BoxDecider
@onready var ui: CanvasLayer = %ui
@onready var anim: AnimationPlayer = %anim

var died : bool = false ## A one time thingy

func _ready() -> void:
	GlobalSignals.DamagePlayer.connect(hurt)
	GlobalSignals.DamageEnemy.connect(hit_enemy)
	GlobalSignals.FightWin.connect(fight_win)
	Global.current_game_state = Global.game_states.FIGHT

func _process(delta: float) -> void:
	pass

func hurt(damage: float) -> void:
	pass

func hit_enemy(damage: float) -> void:
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
