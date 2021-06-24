extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#[damage, model, name]
func update_weapon(weapon):
	if weapon == 1:
		return[50,load("res://scenes/shotgun.tscn"),"Shotgun"]
	
