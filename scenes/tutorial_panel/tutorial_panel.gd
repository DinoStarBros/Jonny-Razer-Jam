extends Control
class_name TutorialPanel

@onready var pages : Array[MarginContainer] = [
	%page1,
	%page2,
	%page3,
	
]

var current_page : int = 0

func _ready() -> void:
	_update_page()
	
	%next.pressed.connect(_next_pressed)
	%prev.pressed.connect(_prev_pressed)
	%close.pressed.connect(
		func(): hide()
	)

func _next_pressed() -> void:
	_change_current_page_num(1)

func _prev_pressed() -> void:
	_change_current_page_num(-1)

func _change_current_page_num(change: int) -> void:
	current_page += change
	current_page = wrapi(current_page, 0, pages.size())
	_update_page()

func _update_page() -> void:
	
	var ndex : int = -1
	for page in pages:
		page.hide()
		ndex += 1
		if ndex == current_page:
			page.show()
