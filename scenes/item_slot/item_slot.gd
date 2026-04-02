extends PanelContainer
class_name ItemSlot

@export var use_button : String

var key_text : String
var item_held : Item


func _ready() -> void:
	await get_tree().process_frame
	%text.text = key_text

func _unhandled_key_input(event: InputEvent) -> void:
	
	if not Global.current_game_state == Global.game_states.FIGHT:
		return
	
	if Input.is_action_just_pressed(use_button):
		
		if get_child_count() >= 1:
			for child in get_children():
				if child is Item:
					item_held = child
			
			#item_held = get_child(0)
			if item_held:
				item_held.use()
			
				Global.cursor.cursor_speed = Global.cursor.base_speed
