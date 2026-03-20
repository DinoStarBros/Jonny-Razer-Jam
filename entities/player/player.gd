extends Node2D
class_name Player

@onready var health_component: HealthComponent = %HealthComponent
@onready var box_decider: BoxDecider = %BoxDecider

var died : bool = false ## A one time thingy

func _ready() -> void:
	GlobalSignals.DamagePlayer.connect(hurt)
	Global.current_game_state = Global.game_states.FIGHT

func _process(delta: float) -> void:
	if health_component.hp <= 0 and !died:
		Global.current_game_state = Global.game_states.DEAD
		get_tree().paused = true
		died = true

func hurt(damage: float) -> void:
	_play_hurt_sfx()
	health_component.hp -= damage

func _play_hurt_sfx() -> void:
	%hurt1.pitch_scale = randf_range(0.8, 1.0)
	%hurt1.play()
	%hurt2.pitch_scale = randf_range(0.8, 1.0)
	%hurt2.play()
