extends Line2D

@onready var cursor: Sprite2D = %cursor

var endpoints_x : Vector2 ## X is neg/left, Y is pos/right
var cursor_move_mode : bool = true ## True = right, False = left
var cursor_speed : float = 400

func _ready() -> void:
	endpoints_x.x = points[0].x + global_position.x
	endpoints_x.y = points[1].x + global_position.x
	
	print(endpoints_x)

func _process(delta: float) -> void:
	if cursor_move_mode:
		cursor.global_position.x += cursor_speed * delta
		
		if cursor.global_position.x >= endpoints_x.y:
			cursor_move_mode = false
	else:
		cursor.global_position.x += -cursor_speed * delta
	
		if cursor.global_position.x <= endpoints_x.x:
			cursor_move_mode = true
