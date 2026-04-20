extends Resource
class_name BaseEntityStats

enum scaling_function_types {
	LINEAR, EXPONENTIAL, LOGARITHMIC, QUADRATIC
}

@export var max_hp : float

## True = Chooses Boxes Randomly;
## False = Chooses Boxes on a Pattern
@export var random_or_pattern : bool 
@export var box_scenes : Array[PackedScene]

## X is min spawn amount, Y is max spawn amount
@export var spawn_amount_range : Vector2i = Vector2i(1,2)
## X is min spawn time, Y is max spawn time
@export var spawn_time_range : Vector2 = Vector2(1,2)

## How fast the box will go to the left, usually for defend boxes
@export var box_speed_range : Vector2 = Vector2(100, 200)

## Most of this stuff is for the player
@export_category("Displayed Combat Stats")
@export var damage : float = 2
@export var crit_chance : float = 3
@export var item_efficiency : int = 0
@export var luck : float = 0

## The scaling strength for the stats/values that increase/decrease
@export_category("Scaling Strengths")
@export var hp_scaling_strength : float = 0.1
@export var hp_scale_type : scaling_function_types

@export var damage_scaling_strength : float = 0.1
@export var damage_scale_type : scaling_function_types

@export var box_spawn_time_scaling_strength : float = 0.1
@export var box_spawn_time_scale_type : scaling_function_types

@export var box_speed_scaling_strength : float = 0.1
@export var box_speed_scale_type : scaling_function_types
