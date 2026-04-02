extends Resource
class_name EntityStats

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

@export_category("Displayed Combat Stats")
@export var damage : float = 2
@export var crit_chance : float = 3
@export var item_efficiency : int = 0
@export var luck : float = 0
