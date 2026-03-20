extends Node2D
class_name Enemy1

@onready var anim: AnimationPlayer = %anim
@onready var health_component: HealthComponent = %HealthComponent
@onready var stats_allocator: StatsAllocator = %StatsAllocator

func _ready() -> void:
	GlobalSignals.CursorMiss.connect(_cursor_miss)

func _cursor_miss() -> void:
	GlobalSignals.DamagePlayer.emit(stats_allocator.stats.damage)
