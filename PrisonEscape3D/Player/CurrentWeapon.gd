extends Position3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var weapon1 = preload("res://MyWeapons/AK47.tscn") #preloads ak
var weapon2 = preload("res://MyWeapons/Shotgun.tscn") #preloads shotgun

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	if Input.is_action_just_pressed("weapon1"): #if '1' is pressed...
		print("change to AK")
		get_child(0).queue_free() #removes the other weapon
		var gun1 = weapon1.instance() #gets the ak
		gun1.transform = Transform.IDENTITY
		add_child(gun1) #adds ak to the scene/shows it
		
	if Input.is_action_just_pressed("weapon2"):
		print("change to Shawty")
		get_child(0).queue_free()
		var gun2 = weapon2.instance()
		gun2.transform = Transform.IDENTITY
		add_child(gun2)#changed the variable so it's different to weapon 1
