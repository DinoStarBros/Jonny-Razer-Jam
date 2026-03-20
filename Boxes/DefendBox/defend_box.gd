extends Box
class_name DefendBox

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
