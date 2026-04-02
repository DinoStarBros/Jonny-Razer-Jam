extends EntityComponentClass
## Component for entities that decides what, when, and where for the box spawning
class_name BoxDecider

## True = Chooses Boxes Randomly;
## False = Chooses Boxes on a Pattern
var random_or_pattern : bool 
var box_scenes : Array[PackedScene]
var spawn_amount_range : Vector2i
var spawn_time_range : Vector2
var box_speed_range : Vector2
var stats : EntityStats
var enemy_stat_mult : float
## Damage value after going through scaling
var final_damage : float

#@export var final_damage_text : Label ## UI text that shows the final damage

func _ready() -> void:
	await get_tree().process_frame
	
	random_or_pattern = stats.random_or_pattern
	box_scenes = stats.box_scenes
	
	if get_parent() is Enemy:
		enemy_stat_mult = (Global.enemy_idx + 1)
	else:
		enemy_stat_mult = 1
	
	spawn_amount_range = stats.spawn_amount_range
	
	# Decreases spawn time, making the enemy spawn boxes faster
	spawn_time_range = stats.spawn_time_range * scaling(enemy_stat_mult, 40, false)
	
	# Increases box speed, making defend boxes move faster to the left
	box_speed_range = stats.box_speed_range * scaling(enemy_stat_mult, 50, true)
	
	final_damage = roundi(
		stats.damage * scaling(enemy_stat_mult - 1, 5, true)
		)
	
	%SpawnTimer.timeout.connect(_spawn_timer_timeout)
	%SpawnTimer.start(
		randf_range(spawn_time_range.x, spawn_time_range.y)
		)

func _spawn_timer_timeout() -> void:
	
	var spawn_amount : int = randi_range(spawn_amount_range.x, spawn_amount_range.y)
	var spawn_time : float = randf_range(spawn_time_range.x, spawn_time_range.y)
	
	%SpawnTimer.start(spawn_time)
	
	if not Global.current_game_state == Global.game_states.FIGHT:
		return
	
	for n in spawn_amount:

		
		
		## 1st param, box scene
		## 2nd param, pos x, if it's not random x
		var box_instance : Box = box_scenes.pick_random().instantiate()
		if box_instance is DefendBox:
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
	#final_damage_text.text = str(
		#"Damage: ", roundi(final_damage)
		#)
	pass
	
	#Global.final_damage = final_damage
