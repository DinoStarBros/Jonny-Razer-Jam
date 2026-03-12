extends Control

const level_scns : Array[String] = [
	"res://Screens/prototype_1/combo_knight_like_proto.tscn",
	
]

@onready var button_and_level : Dictionary = {
	"L1": [
		%l1, func():SceneManager.change_scene(level_scns[0])
		],
	"L2": [
		%l2, func():print("2")
		],
	"L3": [
		%l3, func():print("3")
		],
	
}

func _ready() -> void:
	for n in button_and_level.values(): if n[0] is Button:
		n[0].pressed.connect(n[1])
