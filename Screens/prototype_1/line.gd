extends Line2D

@export var time_curve : Curve
@export var spawn_amnt_curve : Curve

@onready var cursor: Area2D = %cursor

var endpoints_x : Vector2 ## X is neg/left, Y is pos/right
var boxes_scns : Array[PackedScene] = [
	load("res://Boxes/AttackBox/attack_box.tscn"),
	
]

func _ready() -> void:
	endpoints_x.x = points[0].x + global_position.x
	endpoints_x.y = points[1].x + global_position.x
	%cursor.endpoints_x = endpoints_x
	
	for n in randi_range(2,4):
		_spawn_box(randf_range(endpoints_x.x, endpoints_x.y), 0)

func _process(delta: float) -> void:
	pass

func _spawn_box(
	pos_x: float, 
	box_type: int ## 0=attack box
	) -> void:
	
	var box : Box = boxes_scns[box_type].instantiate()
	%box_parent.add_child(box)
	box.global_position.x = pos_x

func _on_spawn_timer_timeout() -> void:
	var boxes_amnt : int = %box_parent.get_child_count()
	
	for n in spawn_amnt_curve.sample(boxes_amnt) + randi_range(-1, 1):
		_spawn_box(randf_range(endpoints_x.x, endpoints_x.y), 0)
	
	%spawnTimer.start(time_curve.sample(boxes_amnt))
