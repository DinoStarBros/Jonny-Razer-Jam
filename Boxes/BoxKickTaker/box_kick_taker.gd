extends Node2D
class_name BoxKickTaker

func _init() -> void:
	GlobalSignals.ZarchivasKick.connect(_zarchivas_kick)

func _zarchivas_kick() -> void:
	get_parent().global_position.x += 300
	GlobalSignals.DamageEnemy.emit(Global.player_final_damage, true)
	if get_parent().global_position.x > Global.endpoints_x.y:
		get_parent().queue_free()
