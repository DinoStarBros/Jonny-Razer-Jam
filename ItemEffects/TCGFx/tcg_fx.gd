extends ItemEffect
class_name CardFX

@onready var sprite: Sprite2D = %sprite

var rotation_speed : float
var duration : float = 1

const cards_amnt : int = 4
const cards_scns : Array[PackedScene] = [
	preload("res://Boxes/CardBoxes/BurnBox/burn_box.tscn"),
	preload("res://Boxes/CardBoxes/PoisonBox/poison_box.tscn"),
]

func _ready() -> void:
	item_duration_timer.start(duration)
	
	for n in cards_amnt:
		_spawn_card()

func _process(delta: float) -> void:
	_rotate_move(delta)
	
	rotation_speed += delta * 300

func _rotate_move(delta: float) -> void:
	sprite.rotation_degrees += rotation_speed * delta

func _spawn_card() -> void:
	var box_instance : Box = cards_scns.pick_random().instantiate()
	GlobalSignals.SpawnBoxRandomX.emit(box_instance)
