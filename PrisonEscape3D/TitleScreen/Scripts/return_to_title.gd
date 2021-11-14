extends Control




func _on_Button_pressed():
	get_tree().change_scene("res://TitleScreen/TitleScreen.tscn")


func _on_FullScreen2_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
	pass # Replace with function body.


func _on_Music_pressed():
	SoundPlayer.play("res://Sounds/My Song 11.wav") 
	pass # Replace with function body.
