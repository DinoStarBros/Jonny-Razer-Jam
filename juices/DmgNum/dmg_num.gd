extends Node2D
class_name DmgNum

@onready var pivot: Node2D = %pivot

var text : String
var ini_vel : float

func _ready() -> void:
	
	%DmgText.text = text
	ini_vel = randf_range(-60,60)
	pivot.scale *= randf_range(0.8, 1.2)
	pivot.rotation_degrees = ini_vel * 1.5

func _process(delta : float) -> void:
	position.x += ini_vel * delta
	position.y += ini_vel * delta
	
	pivot.rotation_degrees = lerp(pivot.rotation_degrees, 0.0, 12.0 * delta)
