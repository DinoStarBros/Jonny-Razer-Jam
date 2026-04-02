extends EntityComponentClass
class_name HealthComponent

@export var health_bar : Range
@export var health_text : Label

var max_hp : float = 100.0
var hp : float:
	set(value):
		hp = clampi(value, 0.0, max_hp)
var stats : EntityStats
var died : bool = false
var enemy_stat_mult : float

## Enemy damaging the player
func player_hurt(damage: float) -> void:
	hp -= roundi(damage)
	if hp <= 0:
		if !died:
			Global.current_game_state = Global.game_states.DEAD
			get_tree().paused = true
			died = true
	else:
		get_parent().play_hurt_sfx()

## Player damaging the enemy
func enemy_hurt(damage: float) -> void:
	hp -= roundi(damage)
	#if hp <= 0:
		#if !died:
			#Global.current_game_state = Global.game_states.WIN
			#died = true
			#enemy_dead()
	

func _ready() -> void:
	await get_tree().process_frame
	
	if get_parent() is Enemy:
		enemy_stat_mult = (Global.enemy_idx + 1)
	else:
		enemy_stat_mult = 1
	
	max_hp = roundi(
		stats.max_hp * scaling(enemy_stat_mult - 1, 4, true)
		)
	hp = roundi(max_hp)
	
	if get_parent() is Player:
		GlobalSignals.DamagePlayer.connect(player_hurt)
	else:
		GlobalSignals.DamageEnemy.connect(enemy_hurt)

func _process(delta: float) -> void:
	if health_text:
		health_text.text = str(roundi(hp), " / ", roundi(max_hp))
		#health_text.text = str((hp), " / ", (max_hp))
	
	if health_bar:
		health_bar.max_value = max_hp
		health_bar.value = hp
	
	if get_parent() is Enemy: if hp <= 0:
		if Global.current_game_state == Global.game_states.FIGHT:
			if !died:
				Global.current_game_state = Global.game_states.WIN
				died = true
				enemy_dead()

func enemy_dead() -> void:
	GlobalSignals.FightWin.emit()
	get_parent().queue_free()
