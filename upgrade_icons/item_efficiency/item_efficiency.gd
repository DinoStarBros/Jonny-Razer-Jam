extends Upgrade
class_name ItemEfficiency

func _ready() -> void:
	if Global.item_efficiency < 3:
		Global.item_efficiency += 1
	else:
		Global.luck += 5
