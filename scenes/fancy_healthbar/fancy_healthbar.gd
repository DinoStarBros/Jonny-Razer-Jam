extends ProgressBar
class_name FancyHealthbar

@onready var white_bar: ProgressBar = %WhiteBar
@onready var hp_barticle: GPUParticles2D = %HpBarticle
@onready var hp_text: Label = %HPText
@onready var name_text: Label = %name_text

var wb_desiredVal : float
var lerp_difference : float
var white_bar_end_pos : float
var bar_end_pos : float
var the_name : String:
	set(value):
		the_name = value
		name_text.text = the_name

func _ready() -> void:
	await get_tree().process_frame
	white_bar.fill_mode = fill_mode

func _process(delta: float) -> void:
	wb_desiredVal = value
	white_bar.value = lerp(white_bar.value, wb_desiredVal, 5 * delta)
	white_bar.max_value = max_value
	
	hp_text.text = str(
		roundi(wb_desiredVal), " / ", roundi(max_value)
	)
	
	if fill_mode == FillMode.FILL_BEGIN_TO_END:
		white_bar_end_pos = (white_bar.value/white_bar.max_value) * white_bar.size.x
		bar_end_pos = (value/max_value) * size.x
	else:
		white_bar_end_pos = (1 - (white_bar.value/white_bar.max_value)) * white_bar.size.x
		bar_end_pos = (1 - (value/max_value)) * size.x
		hp_barticle.rotation = PI
	
	lerp_difference = white_bar.value - value
	
	hp_barticle.emitting = lerp_difference >= 0.6
	hp_barticle.self_modulate = self_modulate
	
	hp_barticle.position.x = white_bar_end_pos
