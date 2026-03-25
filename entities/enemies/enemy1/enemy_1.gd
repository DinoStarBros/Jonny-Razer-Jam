extends Enemy
class_name Enemy1

@onready var anim: AnimationPlayer = %anim
@onready var health_component: HealthComponent = %HealthComponent
@onready var stats_allocator: StatsAllocator = %StatsAllocator
@onready var box_decider: BoxDecider = %BoxDecider

func _ready() -> void:
	GlobalSignals.CursorMiss.connect(_cursor_miss)

func _cursor_miss() -> void:
	GlobalSignals.DamagePlayer.emit(box_decider.final_damage)
