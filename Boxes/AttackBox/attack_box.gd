extends Box
class_name AttackBox

func _ready() -> void:
	boxes_amount += 1
	id = boxes_amount
	z_index = id
	%Label.text = str(z_index)
	
	scale.x *= randf_range(0.5, 2)

func _exit_tree() -> void:
	boxes_amount -= 1

func slice() -> void:
	%cs.disabled = true
	%anim.play("break")
