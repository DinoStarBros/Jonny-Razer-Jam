extends Control
class_name Settings

@onready var button_pressed: AudioStreamPlayer = %button_pressed
@onready var screen_shake: Button = %screen_shake
@onready var frame_freeze: Button = %frame_freeze
@onready var crt_effect: Button = %crt_effect
@onready var master_vol_slider: HSlider = %master_volume
@onready var music_vol_slider: HSlider = %music_volume
@onready var sfx_vol_slider: HSlider = %sfx_volume
@onready var translations: OptionButton = %Translations

var resolutions : Array[Vector2i] = [
	Vector2i(1920, 1080),
	Vector2i(1600, 900),
	Vector2i(1280, 720),
]
var sure_quit:bool = false
var allow_audios_play: bool = false

func _ready()->void:
	
	crt_effect.pressed.connect(_on_crt_effect_pressed)
	translations.item_selected.connect(_on_translations_selected)
	
	await get_tree().process_frame
	_load()
	allow_audios_play = true

func on_pause() -> void:
	sure_quit = false

func on_resume() -> void:
	get_tree().paused = false
	_save()

func _save()->void: ## Saves the settings stuff
	SaveLoad.save_settings_stuff()

func _load()->void: ## Loads the settings stuff
	SaveLoad.load_settings_stuff()
	
	# Updates the visuals and sliders in the settings menu
	master_vol_slider.value = SaveLoad.settings.master_volume
	music_vol_slider.value = SaveLoad.settings.music_volume
	sfx_vol_slider.value = SaveLoad.settings.sfx_volume
	
	if SaveLoad.settings.screen_shake_value:
		screen_shake.text = str("On")
	else:
		screen_shake.text = str("Off")
	
	if SaveLoad.settings.frame_freeze_value:
		frame_freeze.text = str("On")
	else:
		frame_freeze.text = str("Off")
	
	if SaveLoad.settings.crt_effect_value:
		crt_effect.text = str("On")
	else:
		crt_effect.text = str("Off")
	
	translations.select(SaveLoad.settings.language_idx)
	TranslationServer.set_locale(translations.get_item_text(SaveLoad.settings.language_idx))

func _on_reset_pressed()->void:
	SaveLoad._reset_save_file()
	SaveLoad._load()

func _on_master_volume_value_changed(value: float)->void:
	if allow_audios_play:
		%vol_change_master.pitch_scale = max(value, 0.01)
		%vol_change_master.play(0.005)
	
	SaveLoad.settings.master_volume = value

func _on_music_volume_value_changed(value: float)->void:
	if allow_audios_play:
		%vol_change_music.pitch_scale = max(value, 0.01)
		%vol_change_music.play(0.005)
	
	SaveLoad.settings.music_volume = value

func _on_sfx_vol_value_changed(value: float)->void:
	if allow_audios_play:
		%vol_change_sfx.pitch_scale = max(value, 0.01)
		%vol_change_sfx.play(0.005)
	
	SaveLoad.settings.sfx_volume = value

func _on_frame_freeze_pressed() -> void:
	SaveLoad.settings.frame_freeze_value = not SaveLoad.settings.frame_freeze_value
	button_pressed.pitch_scale = randf_range(1.8,2.2)
	button_pressed.play()
	
	if SaveLoad.settings.frame_freeze_value:
		frame_freeze.text = str("On")
	else:
		frame_freeze.text = str("Off")

func _on_screen_shake_pressed() -> void:
	SaveLoad.settings.screen_shake_value = not SaveLoad.settings.screen_shake_value
	button_pressed.pitch_scale = randf_range(1.8,2.2)
	button_pressed.play()
	
	if SaveLoad.settings.screen_shake_value:
		screen_shake.text = str("On")
	else:
		screen_shake.text = str("Off")

func _on_crt_effect_pressed() -> void:
	SaveLoad.settings.crt_effect_value = not SaveLoad.settings.crt_effect_value
	button_pressed.pitch_scale = randf_range(1.8,2.2)
	button_pressed.play()
	
	if SaveLoad.settings.crt_effect_value:
		crt_effect.text = str("On")
	else:
		crt_effect.text = str("Off")

func _on_translations_selected(index: int) -> void:
	SaveLoad.settings.language_idx = index
	
	var item_string : String = (translations.get_item_text(index))
	TranslationServer.set_locale(item_string)
