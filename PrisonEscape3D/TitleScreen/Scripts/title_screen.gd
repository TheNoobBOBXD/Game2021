extends Control


func _ready():
	$Menu/CenterRow/Buttons.grab_focus()


func _on_NewGameButton_pressed():
	pass
	get_tree().change_scene("res://Scenes/World.tscn")
	



func _on_ControlButton_pressed():
	
	get_tree().change_scene("res://TitleScreen/Game/Control.tscn")
	


func _on_Settings_pressed():
	get_tree().change_scene("res://TitleScreen/Game/Settings.tscn")
	


func _on_Quit_pressed():
	get_tree().quit()

#
#func _on_FadeIn_fade_finished():
#	$FadeIn/AnimationPlayer.stop
#	pass # Replace with function body.
