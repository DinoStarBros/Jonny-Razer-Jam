extends CanvasLayer
class_name Inventory

func _ready() -> void:
	Global.inventory = self
	
	var idx : int = 0
	for i in %items.get_children(): if i is ItemSlot:
		idx += 1
		i.key_text = str(idx, ".")

func add_item(item_scn: PackedScene) -> void:
	for i in %items.get_children(): if i is ItemSlot:
		if i.get_child_count() == 1:
			
			var item : Item = item_scn.instantiate()
			i.add_child(item)
			break
