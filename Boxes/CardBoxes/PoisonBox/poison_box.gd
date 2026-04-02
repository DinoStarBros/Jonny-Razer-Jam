extends CardBox
class_name PoisonBox

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
	
	#GlobalSignals.DamageEnemy.emit(damage)
	GlobalSignals.DebuffEnemy.emit(
		DebuffsComponent.Debuffs.POISON,
		6
		)
