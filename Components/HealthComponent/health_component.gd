extends Node2D
class_name HealthComponent

@export var health_bar : Range
@export var health_text : Label

var max_hp : float = 100.0
var hp : float:
	set(value):
		hp = clampf(value, 0.0, max_hp)
var stats : EntityStats

func _ready() -> void:
	max_hp = stats.max_hp
	hp = max_hp

func _process(delta: float) -> void:
	if health_text:
		health_text.text = str(roundi(hp), " / ", roundi(max_hp))
	
	if health_bar:
		health_bar.max_value = max_hp
		health_bar.value = hp
