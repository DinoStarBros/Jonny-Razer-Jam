extends ItemEffect
class_name ZarchivasFX

func kick() -> void:
	GlobalSignals.ZarchivasKick.emit()
	Global.camera.screen_shake(10, 0.1)
