extends Weapon

export var fire_range = 12
onready var blood = preload("res://Particles/Spark.tscn")

func _ready():
	raycast.cast_to = Vector3(0,0, - fire_range)
	
