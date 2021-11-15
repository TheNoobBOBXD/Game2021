extends Control


func _ready():
	$Menu/CenterRow/Buttons.grab_focus() 


func _on_NewGameButton_pressed():
	get_tree().change_scene("res://Scenes/Level0.tscn") #when pressed it starts the game - loads level0

func _on_ControlButton_pressed():
	get_tree().change_scene("res://TitleScreen/Game/Control.tscn") #changes to the controls scene
	

func _on_Settings_pressed():
	get_tree().change_scene("res://TitleScreen/Game/Settings.tscn") #changes to the settings scene - music is there
	
	


func _on_Quit_pressed(): #literally quites the game if it is pressed.
	get_tree().quit()

#
#func _on_FadeIn_fade_finished():
#	$FadeIn/AnimationPlayer.stop
#	pass # Replace with function body.
#didn't want it and didn't work
