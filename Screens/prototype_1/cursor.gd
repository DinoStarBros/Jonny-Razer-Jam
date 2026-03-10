extends Area2D
class_name Cursor

var current_box : Box
var cursor_move_mode : bool = true ## True = right, False = left
var cursor_speed : float = 400
var endpoints_x : Vector2
var combo : int = 0

const speed_increase : int = 50

func _ready() -> void:
	#area_entered.connect(_box_entered)
	#area_exited.connect(_box_exited)
	pass

func _process(delta: float) -> void:
	#%text.text = str(current_box)
	%Label.text = str(get_overlapping_areas(),
	" : \n",
	current_box
	)#str("Combo!: ",combo)
	
	_move_handle(delta)
	

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		var overlaps : Array = get_overlapping_areas()
		var box_zorders_in_area : Array = []
		for box in overlaps: if box is Box:
			box_zorders_in_area.append(box.id)
		
		if overlaps.size() > 0:
			var biggest_box_idx : int = box_zorders_in_area.find(box_zorders_in_area.max())
			var biggest_box : Box = get_overlapping_areas()[biggest_box_idx]
			
			biggest_box.queue_free()
			
			_succesful_box_hit()
		else:
			_failed_box_hit()

func _move_handle(delta: float) -> void:
	if cursor_move_mode:
		global_position.x += cursor_speed * delta
		
		if global_position.x >= endpoints_x.y:
			cursor_move_mode = false
	else:
		global_position.x += -cursor_speed * delta
	
		if global_position.x <= endpoints_x.x:
			cursor_move_mode = true
	
	global_position.x = clamp(global_position.x, endpoints_x.x, endpoints_x.y)

func _box_entered(area: Area2D) -> void:
	if area is Box:
		if current_box:
			if area.z_index >= current_box.z_index:
				current_box = area
		else:
			current_box = area

func _box_exited(area: Area2D) -> void:
	if area is Box:
		if get_overlapping_areas().size() <= 0:
			current_box = null

func _succesful_box_hit() -> void:
	cursor_speed += speed_increase
	combo += 1
	
	%hit1.pitch_scale = randf_range(0.8, 1.1)
	%hit1.play()
	%hit2.pitch_scale = randf_range(0.8, 1.1)
	%hit2.play()

func _failed_box_hit() -> void:
	cursor_speed = 400
	combo = 0
	%failHit.pitch_scale = randf_range(0.8, 1.0)
	%failHit.play()
	%failHit2.pitch_scale = randf_range(0.8, 1.0)
	%failHit2.play()
