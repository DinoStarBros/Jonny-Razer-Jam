extends ItemEffect
class_name CardFX

var rotation_speed : float

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	_rotate_move(delta)
	
	rotation_speed += delta * 30

func _rotate_move(delta: float) -> void:
	rotation_degrees += rotation_speed * delta
