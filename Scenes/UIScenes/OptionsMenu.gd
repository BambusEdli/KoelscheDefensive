extends Control

signal stopMusic()
signal CloseOptionsMenu()
signal game_finished(result)

#onready var media_player: MediaPlayer = $MediaPlayer

func _on_Back_pressed():
	emit_signal("CloseOptionsMenu")


func _on_HSlider_value_changed(value):
	if value > $HBoxContainer/Column1/HSlider_Sound.min_value:
		AudioServer.set_bus_mute(0, false)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	else:
		AudioServer.set_bus_mute(0, true)


func _on_HSlider_Music_value_changed(value):
	if value > $HBoxContainer/Column1/HSlider_Music.min_value:
		AudioServer.set_bus_mute(1, false)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	else:
		AudioServer.set_bus_mute(1, true)


func _on_HSlider_Sounds_value_changed(value):
	if value > $HBoxContainer/Column1/HSlider_Sounds.min_value:
		AudioServer.set_bus_mute(2, false)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sounds"), value)
	else:
		AudioServer.set_bus_mute(2, true)
