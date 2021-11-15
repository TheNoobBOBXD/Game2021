extends KinematicBody
#11.48 need to fix player
var player
var follow_player = false
var move_speed = 100
var can_shoot = false
var health = 2

onready var blood  = preload("res://Particles/Blood.tscn")
onready var bullet = preload("res://EnemyBullet.tscn")#load bullet scene here

var ammo_pack = preload("res://MYcreations/AmmoCrate.tscn")
var med_pack = preload ("res://MYcreations/Medpack.tscn") 
#loads the med pack and the ammo pack

func _ready():
	pass

func hit_zombie():
	health -= 1
	if health <= 0: #when the zombie dies it will 'dissapear' 
		var a = blood.instance()
		a.global_transform = global_transform
		#a.global_transform.origin = $Raycast.get_collision_point()
		get_parent().add_child(a)
		a.set_emitting(true)
		print("splat")
		SoundPlayer.play("res://Sounds/Sfx/Random/Randomize3.wav")
		queue_free() #removes the zombie after it dies
		
	else:
		pass



func _physics_process(delta):
	if follow_player == true:
		var pos = player.global_transform.origin
		var facing = -global_transform.basis.z
		look_at(pos, Vector3.UP)
		if $RayCast.get_collider() != null:
			if $RayCast.get_collider().name == "Player":
				move_and_slide(facing * move_speed * delta, Vector3.UP)
				$ShooterGhost/AnimationPlayer.play("BadGhostshoot") #animation shooting
			else:
				$ShooterGhost/AnimationPlayer.play("GhostAnimation")#plays the idela animation
		if can_shoot:
			if $RayCast.get_collider() != null:
				if $RayCast.get_collider().name == "Player":
					Playerinfo.change_health(rand_range(-3,-5)) #changes the player health between 3 and 5 health
					$RayCast.get_collider().hit()
					SoundPlayer.play("res://Sounds/Sfx/Hitorhurt/001.wav") #plays sound hit
					print("yeet")
					if Playerinfo.get_health() <= 0: #if the player has no more health
						get_tree().reload_current_scene() #reloads the level that the player is currently in
						Playerinfo.change_lives(-1) #changes life
						Playerinfo.reset() #resets the information (so max health and everything)
						SoundPlayer.play("res://Sounds/Sfx/Explosion/Explosion_002.wav")
			can_shoot = false
			$Timer.start()


func _on_Area_body_entered(body): 
	if body.name == "Player": #checking if the player has entered the body
		$RayCast.set_enabled(true) 
		print("found player") #this tells me that the player has been found - all print statements are to check/look at the debugger and see whether it actually runs this part of the code.
		follow_player = true
		can_shoot = true
		player = body




func _on_Area_body_exited(body): #when the player has exited the body
	if body.name == "Player":
		$RayCast.set_enabled(false)
		print("lost player")
		follow_player = false #can't see, can't shoot or follow the player
		can_shoot = false
	pass


func _on_Timer_timeout(): #the time between each shot that it fires.
	can_shoot = true
	pass # Replace with function body.
