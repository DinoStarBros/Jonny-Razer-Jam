extends Resource
class_name LevelResource

## The scenes of the enemies that finna be in the level
@export var enemy_scns : Array[PackedScene]
## The amount of enemies that finna be in that level
@export var enemy_amount : int = 1
## The boss that you fight as the last enemy in the level
@export var boss_scn : PackedScene
