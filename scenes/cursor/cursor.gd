extends Area2D
class_name Cursor

const speed_increase : int = 50
const base_speed : float = 300
const max_speed : float = 1200

var current_box : Box
var cursor_move_mode : bool = true ## True = right, False = left
var cursor_speed : float = base_speed
var endpoints_x : Vector2
var combo : int = 0
var box_clicked : bool = false

func _ready() -> void:
	GlobalSignals.CombatStart.connect(_combat_done)
	GlobalSignals.DamagePlayer.connect(_player_hurt)
	GlobalSignals.Crit.connect(_crit)
	
	Global.cursor = self

func _process(delta: float) -> void:
	
	cursor_speed = clamp(cursor_speed, 0, max_speed)
	
	_move(delta)
	
	#%text.text = str("Combo : ", combo)
	
	%debug.text = str(
		#"Speed: ", cursor_speed, 
		#" ",
		"Combo: ", combo
	)

func _unhandled_input(event: InputEvent) -> void:
	if not Global.current_game_state == Global.game_states.FIGHT:
		box_clicked = false
		return
	
	if Input.is_action_just_pressed("click") and !box_clicked:
		determin_box_click()
		box_clicked = true
	
	if Input.is_action_just_released("click") and box_clicked:
		box_clicked = false

func determin_box_click() -> void:
		var overlaps : Array = get_overlapping_areas()
		var box_zorders_in_area : Array = []
		for box in overlaps: if box is Box:
			box_zorders_in_area.append(box.z_index)
		
		if overlaps.size() > 0:
			var biggest_box_idx : int = box_zorders_in_area.find(box_zorders_in_area.max())
			var biggest_box : Box = get_overlapping_areas()[biggest_box_idx]
			
			biggest_box.slice()
			
			_succesful_box_hit()
			if biggest_box is DefendBox:
				%block.pitch_scale = randf_range(0.7,0.9)
				%block.play()
				GlobalSignals.Defended.emit()
		else:
			_failed_box_hit()

func _move(delta: float) -> void:
	if not Global.current_game_state == Global.game_states.FIGHT:
		return
	
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
	await get_tree().create_timer(0.05).timeout
	%hit3.pitch_scale = randf_range(0.8, 1.1)
	%hit3.play()
	
	Global.spawn_clickboom(Color.WHITE, global_position)

func _failed_box_hit() -> void:
	cursor_speed = base_speed
	combo = 0
	
	Global.spawn_clickboom(Color.RED, global_position)
	GlobalSignals.CursorMiss.emit()

func _player_hurt(damage: float) -> void:
	# Had to copy-paste instead of just calling
	# _failed_box_hit() cuz it'll be infinite recursion
	cursor_speed = base_speed
	combo = 0
	%hurt1.pitch_scale = randf_range(0.8, 1.0)
	%hurt1.play()
	%hurt2.pitch_scale = randf_range(0.8, 1.0)
	%hurt2.play()

func _combat_done() -> void:
	cursor_speed = base_speed

func _crit() -> void:
	%crit.pitch_scale = randf_range(1.0,1.2)
	%crit.play()
