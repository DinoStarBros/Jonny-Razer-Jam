extends ItemEffect
class_name CS5Effect

var time_val : float = 0
var time_scale : float = 10
var radius : float = 10
var duration : float = 3
var beam_shoot : bool = false
var damage : float

func _ready() -> void:
	
	%Timer.timeout.connect(func():
		Global.current_game_state = Global.game_states.FIGHT
		queue_free()
		)
	
	damage = item_effects.box_decider.final_damage * 3

func _process(delta: float) -> void:
	_visuals(delta)
	
	if beam_shoot:
		%beam.play()
		%beam.pitch_scale = min(2, %beam.pitch_scale + delta)
		%beambass.play()


func _visuals(delta: float) -> void:
	time_val += delta * time_scale
	
	if time_val <= 6:
		radius -= sin(time_val) * 4
	
	%l.position.x = cos(time_val) * radius
	%l.position.y = sin(time_val) * radius
	
	%r.position.x = cos(time_val + PI) * radius
	%r.position.y = sin(time_val + PI) * radius

func beam_start() -> void:
	beam_shoot = true
	%Timer.start(duration)
	
	_extra_sfx()
	
	for dmg in damage:
		GlobalSignals.DamageEnemy.emit(1)
		await get_tree().create_timer(1/(damage/duration)).timeout

func _extra_sfx() -> void:
	const PLAY_TIMES : int = 3
	
	for n in PLAY_TIMES:
		%enemyHit.pitch_scale = randf_range(0.9, 1.1) + 1
		%enemyHit.play(0.14)
		
		await get_tree().create_timer(duration/PLAY_TIMES).timeout 
