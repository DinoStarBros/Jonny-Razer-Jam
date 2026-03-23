extends Line2D

@onready var cursor: Area2D = %cursor

var endpoints_x : Vector2 ## X is neg/left, Y is pos/right
var boxes_scns : Array[PackedScene] = [
	load("res://Boxes/AttackBox/attack_box.tscn"),
	
]

func _ready() -> void:
	endpoints_x.x = points[0].x + global_position.x
	endpoints_x.y = points[1].x + global_position.x
	%cursor.endpoints_x = endpoints_x
	Global.endpoints_x = endpoints_x
	
	GlobalSignals.SpawnBox.connect(_spawn_box)
	GlobalSignals.SpawnBoxRandomX.connect(_spawn_box_rand_x)
	
	%left_endpoint_area.global_position.x = endpoints_x.x

func _process(delta: float) -> void:
	Global.boxes_amnt = %box_parent.get_child_count()

## Function that spawns a box, specify box scene and position x
func _spawn_box(
	box: Box,
	pos_x: float
	) -> void:
	
	%box_parent.add_child(box)
	box.global_position.x = pos_x

## For boxes that just need random position
func _spawn_box_rand_x(box: Box) -> void:
	
	%box_parent.add_child(box)
	box.global_position.x = randf_range(endpoints_x.x, endpoints_x.y)
