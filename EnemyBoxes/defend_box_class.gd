extends Box
class_name DefendBox

@export var icon_sprite : Sprite2D
@export var move_spd_mult : float = 1.0 ## Can determine if the box is inherently faster or slower
@export var max_hp : int = 1

var damage : float
var sliced : bool = false
var leftward_velocity : Vector2
var anim : AnimationPlayer
var collider : CollisionShape2D
var hp : int:
	set(value):
		hp = value

func _init() -> void:
	area_entered.connect(_area_entered)

func _ready() -> void:
	boxes_amount += 1
	id = boxes_amount
	z_index = Global.MAX_BOXES + id
	hp = max_hp
	
	var xcale : float = randf_range(0.8, 2)
	scale.x *= xcale
	icon_sprite.scale.x /= xcale
	
	for child in get_children(): if child is AnimationPlayer: anim = child
	for child in get_children(): if child is CollisionShape2D: collider = child
	
	await get_tree().process_frame
	velocity.x *= move_spd_mult
	leftward_velocity.x = velocity.x # Leftward velocity just stays the same, while I can update velocity

func _exit_tree() -> void:
	boxes_amount -= 1

func _area_entered(area : Area2D) -> void:
	if area.name == "left_endpoint_area":
		deal_damage_to_player()

func deal_damage_to_player() -> void:
	GlobalSignals.DamagePlayer.emit(damage)
	queue_free()

func _physics_process(delta: float) -> void:
	
	if !sliced:
		_move(delta)
	
	if Global.current_game_state == Global.game_states.WIN:
		queue_free()

func slice() -> void:
	hp -= 1
	if hp <= 0:
		final_slice()
	else:
		velocity.x = 500
		tween_velocity_back()

func final_slice() -> void:
	sliced = true
	
	collider.disabled = true
	
	if anim.has_animation("break"):
		anim.play("break")
	else:
		queue_free()

func tween_velocity_back() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "velocity", leftward_velocity, 0.25)
