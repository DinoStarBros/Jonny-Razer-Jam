extends EntityComponentClass
## Component for entities that decides what, when, and where for the box spawning
class_name BoxDecider

@export var final_damage_text : Label

## True = Chooses Boxes Randomly;
## False = Chooses Boxes on a Pattern
var random_or_pattern : bool 
var box_scenes : Array[PackedScene]
var spawn_amount_range : Vector2i
var spawn_time_range : Vector2
var box_speed_range : Vector2
var stats : BaseEntityStats
## Damage value after going through scaling
var final_damage : float

func _ready() -> void:
	await get_tree().process_frame
	
	random_or_pattern = stats.random_or_pattern
	box_scenes = stats.box_scenes
	
	spawn_amount_range = stats.spawn_amount_range
	
	# Decreases spawn time, making the enemy spawn boxes faster
	spawn_time_range = stats.spawn_time_range * Scalings.scale(get_stat_value(), stats.box_spawn_time_scaling_strength, false, stats.box_spawn_time_scale_type)
	
	# Increases box speed, making defend boxes move faster to the left
	box_speed_range = stats.box_speed_range * Scalings.scale(get_stat_value(), stats.box_speed_scaling_strength, true, stats.box_speed_scale_type)
	
	final_damage = roundi(
		stats.damage * Scalings.scale(get_stat_value() - 1, stats.damage_scaling_strength, true, stats.damage_scale_type)
		)
	
	%SpawnTimer.timeout.connect(_spawn_timer_timeout)
	%SpawnTimer.start(
		randf_range(spawn_time_range.x, spawn_time_range.y)
		)

func _spawn_timer_timeout() -> void:
	
	var spawn_amount : int = randi_range(spawn_amount_range.x, spawn_amount_range.y)
	var spawn_time : float = randf_range(spawn_time_range.x, spawn_time_range.y)
	
	if get_parent() is Player:
		spawn_time -= spawn_time * Global.product_box_spawn_speed_multiplier
	
	%SpawnTimer.start(spawn_time)
	
	if not Global.current_game_state == Global.game_states.FIGHT:
		return
	
	for n in spawn_amount:
		
		## 1st param, box scene
		## 2nd param, pos x, if it's not random x
		var box_instance : Box = box_scenes.pick_random().instantiate()
		if box_instance is DefendBox:
			if box_instance is TrapDefendBox:
				# Trap boxes for the enemies
				box_instance.damage = final_damage
				GlobalSignals.SpawnBoxRandomX.emit(box_instance)
			else:
				# Boxes for the enemies
				box_instance.velocity.x = -randf_range(box_speed_range.x, box_speed_range.y)
				box_instance.damage = final_damage
				GlobalSignals.SpawnBox.emit(box_instance, Global.endpoints_x.y)
			
		
		elif box_instance is ProductBox:
			## Boxes for the player
			if Global.boxes_amnt >= Global.MAX_BOXES: 
				return
			
			box_instance.damage = final_damage
			GlobalSignals.SpawnBoxRandomX.emit(box_instance)

func _process(delta: float) -> void:
	final_damage_text.text = str(
		"Damage: ", roundi(final_damage)
		)
	
	if get_parent() is Player:
		Global.player_final_damage = final_damage
