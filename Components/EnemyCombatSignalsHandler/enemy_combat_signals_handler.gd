extends CombatSignalsHandler
## Component that handles signals from GlobalSignals
## that are for combat.
## Like taking damage, blocking, etc.
## for animations and stuff
## For enemy
class_name EnemyCombatSignalsHandler

func _ready() -> void:
	GlobalSignals.DamageEnemy.connect(_hurt_player)
	GlobalSignals.CursorMiss.connect(_cursor_miss)
	GlobalSignals.FightWin.connect(_fight_win)
	GlobalSignals.DamagePlayer.connect(_damage_player)
	GlobalSignals.Defended.connect(_defended)

func _hurt_player(damage: float, allow_crit: bool) -> void:
	hurt_anim()

func _cursor_miss() -> void:
	GlobalSignals.DamagePlayer.emit(box_decider.final_damage)

func _damage_player(damage: float) -> void:
	attack_anim()

func _defended() -> void:
	attack_anim()

func _fight_win() -> void:
	death_anim()

func death_anim() -> void:
	anim.stop()
	anim.play("death")
	await anim.animation_finished
	# This means the death animation is done
	GlobalSignals.StartUpgrade.emit()
	get_parent().queue_free()

func attack_anim() -> void:
	anim.stop()
	anim.play("attack")
	await anim.animation_finished
	idle_anim()

func hurt_anim() -> void:
	anim.stop()
	anim.play("hurt")
	await anim.animation_finished
	idle_anim()

func idle_anim() -> void:
	anim.play("idle")
