extends Node2D
class_name HealthComponent

@export var health_bar : Range
@export var health_text : Label

var max_hp : float = 100.0
var hp : float:
	set(value):
		hp = clampf(value, 0.0, max_hp)
var stats : EntityStats
var died : bool = false

func player_hurt(damage: float) -> void:
	hp -= damage
	if hp <= 0:
		if !died:
			Global.current_game_state = Global.game_states.DEAD
			get_tree().paused = true
			died = true
	else:
		get_parent().play_hurt_sfx()

func enemy_hurt(damage: float) -> void:
	hp -= damage

func _ready() -> void:
	max_hp = stats.max_hp
	hp = max_hp
	
	if get_parent() is Player:
		GlobalSignals.DamagePlayer.connect(player_hurt)
	else:
		GlobalSignals.DamageEnemy.connect(enemy_hurt)

func _process(delta: float) -> void:
	if health_text:
		health_text.text = str(roundi(hp), " / ", roundi(max_hp))
	
	if health_bar:
		health_bar.max_value = max_hp
		health_bar.value = hp
