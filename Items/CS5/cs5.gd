extends Item
class_name CS5

const item_effect_scn : PackedScene = preload("res://ItemEffects/CS5Effect/cs5fx.tscn")

func _ready() -> void:
	%combo_cost_txt.text = str(combo_cost)

func use() -> void:
	if Global.cursor.combo >= combo_cost:
		Global.cursor.combo -= combo_cost
		
		Global.current_game_state = Global.game_states.USING_ITEM
		
		var item_effect : ItemEffect = item_effect_scn.instantiate()
		Global.item_effects.add_child(item_effect)
		
		queue_free()
