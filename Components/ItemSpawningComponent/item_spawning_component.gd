extends Node2D
## Component for product boxes that makes it so
## when the box gets slashed, it has a chance to
## give player the corresponding item
class_name ItemSpawningComponent

@export var item_scn : PackedScene

var item_drop_chance : float

const base_item_chance : float = 1.0/8.0

func on_slash() -> void:
	#item_drop_chance = base_item_chance * diminishing_returns_scaling(Global.luck, 5)
	item_drop_chance = base_item_chance + linear_scaling(base_item_chance, Global.luck)
	
	var rand : float = randf()
	
	#print(
		#item_drop_chance, 
		#":",
		#rand,
		#":",
		#rand < item_drop_chance
	#)
	
	if rand < item_drop_chance:
		_spawn_item()

func _spawn_item() -> void:
	Global.inventory.add_item(item_scn)

func diminishing_returns_scaling(value: float, k: float) -> float:
	return 1 + (value / (value+k))

func linear_scaling(base_chance: float, luck:float) -> float:
	return (1 - base_chance) * (luck / 200)
