extends EntityComponentClass
class_name HealthComponent

@export var health_bar : ProgressBar

var max_hp : float = 100.0
var hp : float:
	set(value):
		hp = clampi(value, 0.0, max_hp)
var stats : BaseEntityStats
var died : bool = false


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
func enemy_hurt(damage: float, allow_crit: bool = true) -> void:
	if allow_crit:
		var percent_crit : float = Global.player_crit_chance / 100
		var rand_val : float = randf()
		var is_crit : bool = rand_val < percent_crit
		
		if is_crit:
			hp -= roundi(damage * Global.CRIT_DMG_MULT)
			Global.spawn_txt(
				str(roundi(damage * Global.CRIT_DMG_MULT)),
				global_position,
				Color.RED
			)
			GlobalSignals.Crit.emit()
		else:
			hp -= roundi(damage)
			Global.spawn_txt(
				str(roundi(damage)),
				global_position
			)
	else:
		hp -= roundi(damage)
		Global.spawn_txt(
			str(roundi(damage)),
			global_position
		)

func _ready() -> void:
	
	await get_tree().process_frame
	
	if get_parent() is Enemy:
		if health_bar:
			health_bar.global_position = get_parent().HEALTHBAR_POSITION
			health_bar.self_modulate = Color.RED
			
			if health_bar is ProgressBar:
				health_bar.fill_mode = health_bar.FillMode.FILL_END_TO_BEGIN
	
	max_hp = roundi(
		stats.max_hp * Scalings.scale(get_stat_value() - 1, stats.hp_scaling_strength, true, stats.hp_scale_type)
		)
	hp = roundi(max_hp)
	
	if get_parent() is Player:
		GlobalSignals.DamagePlayer.connect(player_hurt)
	else:
		GlobalSignals.DamageEnemy.connect(enemy_hurt)

func _process(delta: float) -> void:
	
	if health_bar:
		#if get_parent() is Player:
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
	#get_parent().queue_free()
