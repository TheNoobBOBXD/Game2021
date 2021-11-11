extends Node

var health
var health_max
var ammo
var ammo_max
var lives
var lives_max
var current_level = 0

func _ready():
	health = 100
	health_max = 100
	ammo = 1000
	ammo_max = 1000
	lives = 4
	lives_max = 5
	
func change_health(amount):
	health += amount
	health = clamp(health,0, health_max)
	
func change_ammo(amount):
	ammo += amount
	ammo = clamp(ammo, 0, ammo_max)

func change_lives(amount):
	lives += amount
	lives = clamp(lives,0,lives_max)
	
func get_health():
	return health

func get_ammo():
	return str(ammo)

func get_lives():
	return str(lives)
	
func has_ammo():
	return ammo > 0
	print(ammo)

func change_level():
	current_level += 1
	get_tree().change_scene("res://Scenes/Level" + str(current_level) +".tscn")

func reset():
	health = health_max
