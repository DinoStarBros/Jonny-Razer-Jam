extends Node2D
class_name Enemy1

@onready var anim: AnimationPlayer = %anim
@onready var health_component: HealthComponent = %HealthComponent

func _ready() -> void:
	GlobalSignals.DamageEnemy.connect(hurt)

func hurt(damage: float) -> void:
	health_component.hp -= damage
