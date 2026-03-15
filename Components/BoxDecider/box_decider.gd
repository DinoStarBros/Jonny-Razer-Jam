extends Node2D
## Component for entities that decides what, when, and where for the box spawning
class_name BoxDecider

## True = Chooses Boxes Randomly;
## False = Chooses Boxes on a Pattern
var random_or_pattern : bool 
var box_scenes : Array[PackedScene]

func _ready() -> void:
	%SpawnTimer.timeout.connect(_spawn_timer_timeout)

func _spawn_timer_timeout() -> void:
	## 1st param, box scene
	## 2nd param, pos x
	GlobalSignals.SpawnBoxRandomX.emit(box_scenes[0])
