extends Node2D
## Component for product boxes that makes it so
## when the box gets slashed, it has a chance to
## give player the corresponding item
class_name ItemSpawningComponent

@export var item_scn : PackedScene

var item_chance : float = 1.0/4.0

func on_slash() -> void:
	var rand : float = randf()
	
	prints(rand < item_chance)
	
	if rand < item_chance:
		_spawn_item()

func _spawn_item() -> void:
	Global.inventory.add_item(item_scn)
