extends Node2D
class_name BoxKickTaker

const kick_strength : float = 300

func _init() -> void:
	GlobalSignals.ZarchivasKick.connect(_zarchivas_kick)

func _zarchivas_kick() -> void:
	
	get_parent().position.x += kick_strength * (get_parent().move_spd_mult * 0.5)
	
	GlobalSignals.DamageEnemy.emit(Global.player_final_damage / 2, false)
	if get_parent().global_position.x > Global.endpoints_x.y:
		get_parent().queue_free()
