extends Node

#variables I will use in other code
var health
var health_max
var ammo
var ammo_max
var lives
var lives_max
var current_level = 0
var level_count = 3

func _ready(): #setting values for my variables
	health = 100
	health_max = 100
	ammo = 169
	ammo_max = 5000
	lives = 4
	lives_max = 5

func change_health(amount): #chagne health - shown in game by bar
	health += amount
	health = clamp(health,0, health_max)


func change_ammo(amount): #chaing ammo
	ammo += amount
	ammo = clamp(ammo, 0, ammo_max)
	

func change_lives(amount):
	lives += amount #changing lives by amount (you die you loose one)
	lives = clamp(lives,0,lives_max) 
	if lives <= 0: #if 0 lives aka u lost...
		SoundPlayer.play("res://Sounds/Sfx/Random/Randomize9.wav")
		print("Game Over")
		get_tree().change_scene("res://GameOver.tscn") #change to gameover scene
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) #makes mouse vissable
		pass
		
	
func get_health():
	return health

func get_ammo():
	return str(ammo)

func get_lives():
	return str(lives)
	
func has_ammo():
	return ammo > 0 #if ammo is greater than 0
	print(ammo)

func change_level():
	if current_level < level_count:
		current_level += 1
		get_tree().change_scene("res://Scenes/Level" + str(current_level) +".tscn")
		SoundPlayer.play("res://Sounds/Sfx/Pickup/Pickup_005.wav")
	else:
		#put game over here?
		get_tree().change_scene("res://YOUWIN.tscn") #change to gameover scene
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) #makes mouse vissable
		

func reset():
	health = health_max
