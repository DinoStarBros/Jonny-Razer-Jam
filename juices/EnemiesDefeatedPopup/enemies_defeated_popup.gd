extends CanvasLayer
class_name EnemiesDefeatedPopup

var enemies : int = 67
var max_enemies : int = 69

func _ready() -> void:
	
	%Text.text = str(
		enemies, "/", max_enemies,
		" Scalpers Sabotaged!"
	)
