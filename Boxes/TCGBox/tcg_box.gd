extends ProductBox
class_name TCGBox

@export var item_spawn_comp : ItemSpawningComponent

var damage : float
var flip_x : int = 0

func _ready() -> void:

	boxes_amount += 1
	id = boxes_amount
	z_index = id
	
	scale.x *= randf_range(X_SCALE_RANGE.x, X_SCALE_RANGE.y)
	
	scale *= 1.2

func _exit_tree() -> void:
	boxes_amount -= 1

func slice() -> void:
	%cs.disabled = true
	%anim.play("break")
	
	GlobalSignals.DamageEnemy.emit(damage, true)
	
	item_spawn_comp.on_slash()
