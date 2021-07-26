extends Position3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var weapon1 = preload("res://MyWeapons/AK47.tscn")
var weapon2 = preload("res://MyWeapons/Shotgun.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	if Input.is_action_just_pressed("weapon1"):
		print("change to AK")
		get_child(0).queue_free()
		var gun = weapon1.instance()
		gun.transform = Transform.IDENTITY
		add_child(gun)
		
	if Input.is_action_just_pressed("weapon2"):
		print("change to Shawty")
		get_child(0).queue_free()
		var gun = weapon2.instance()
		gun.transform = Transform.IDENTITY
		add_child(gun)
