extends Box
## The player has to "defend" themself from this box.
## This is an attack from the enemy
class_name DefendBox

var damage : float

func _ready() -> void:
	boxes_amount += 1
	id = boxes_amount
	z_index = Global.MAX_BOXES + id
	%Label.text = str(z_index)
	
	scale.x *= randf_range(0.5, 2)

func _exit_tree() -> void:
	boxes_amount -= 1

func slice() -> void:
	%cs.disabled = true
	queue_free()

func _physics_process(delta: float) -> void:
	_move(delta)
	
	if global_position.x <= Global.endpoints_x.x:
		queue_free()
		GlobalSignals.DamagePlayer.emit(damage)
