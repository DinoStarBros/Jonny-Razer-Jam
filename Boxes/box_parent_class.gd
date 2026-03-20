extends Area2D
## The fuckang abstract parent class of all the boxes or whatever
class_name Box 

static var boxes_amount : int = 0

var id : int = 0
var velocity : Vector2

func slice() -> void:
	pass

#func _init() -> void:
	#global_position.x = clamp(global_position.x, Global.endpoints_x.x, Global.endpoints_x.y)

func _move(delta: float) -> void:
	if not Global.current_game_state == Global.game_states.FIGHT: 
		return
	
	global_position += velocity * delta
