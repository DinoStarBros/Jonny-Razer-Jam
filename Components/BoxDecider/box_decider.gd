extends Node2D
## Component for entities that decides what, when, and where for the box spawning
class_name BoxDecider

## True = Chooses Boxes Randomly;
## False = Chooses Boxes on a Pattern
var random_or_pattern : bool 
var box_scenes : Array[PackedScene]
var spawn_amount_range : Vector2i
var spawn_time_range : Vector2

func _ready() -> void:
	%SpawnTimer.timeout.connect(_spawn_timer_timeout)
	await get_tree().process_frame
	%SpawnTimer.start(
		randf_range(spawn_time_range.x, spawn_time_range.y)
		)

func _spawn_timer_timeout() -> void:

	var spawn_amount : int = randi_range(spawn_amount_range.x, spawn_amount_range.y)
	var spawn_time : float = randf_range(spawn_time_range.x, spawn_time_range.y)
	
	for n in spawn_amount:
		## 1st param, box scene
		## 2nd param, pos x, if it's not random x
		GlobalSignals.SpawnBoxRandomX.emit(box_scenes[0])
	
	%SpawnTimer.start(spawn_time)
