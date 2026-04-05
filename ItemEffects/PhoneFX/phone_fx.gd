extends ItemEffect
class_name PhoneFX

const item_scns : Array[PackedScene] = [
	preload("res://Items/CroakDonalds/croakdonalds.tscn"),
	preload("res://Items/CS5/cs5.tscn"),
	preload("res://Items/Energy/energy.tscn"),
	preload("res://Items/KroFlex/kroflex.tscn"),
	preload("res://Items/Perfume/perfume.tscn"),
	preload("res://Items/Phone/phone.tscn"),
	preload("res://Items/TCG/tcg.tscn"),
	preload("res://Items/Zarchivas/zarchivas.tscn"),
]
const items_amnt : int = 3

func add_items() -> void:
	for n in items_amnt:
		var item_scn : PackedScene = item_scns.pick_random()
		
		Global.inventory.add_item(item_scn)
