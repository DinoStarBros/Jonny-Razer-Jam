extends CardBox
class_name IceBox

var damage : float

func _ready() -> void:
	boxes_amount += 1
	id = boxes_amount
	z_index = id

func _exit_tree() -> void:
	boxes_amount -= 1

func slice() -> void:
	%cs.disabled = true
	%anim.play("break")
	
	%slashsfx.pitch_scale += randf_range(-.1, .1)
	%slashsfx.play()
	Global.camera.screen_shake(6, 0.2)
	GlobalSignals.DebuffEnemy.emit(
		EnemyDebuffsComponent.Debuffs.ICE,
		4
		)
