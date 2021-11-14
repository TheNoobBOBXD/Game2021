extends KinematicBody
#variables
var player
var follow_player = false
var move_speed = 50
var can_shoot = false
var health = 10 #has more health, basic boss!!!

onready var bullet = preload("res://EnemyBullet.tscn")#load bullet scene here

onready var blood  = preload("res://Particles/BigBlood.tscn")

func _ready():
	pass

func hit_zombie():
	health -= 1 #if zombie is hit
	if health <= 0:
		var a = blood.instance()
		a.global_transform = global_transform
		#a.global_transform.origin = $Raycast.get_collision_point()
		get_parent().add_child(a)
		a.set_emitting(true)
		print("splat")
		SoundPlayer.play("res://Sounds/Sfx/Random/Randomize2.wav") #is health is now 0, plays death sound
		queue_free() #removes zombie (it's deatd)



func _physics_process(delta):
	if follow_player == true: #if this is true...
		var pos = player.global_transform.origin
		var facing = -global_transform.basis.z
		look_at(pos, Vector3.UP) #it will look at the player
		if $RayCast.get_collider() != null:
			if $RayCast.get_collider().name == "Player":
				move_and_slide(facing * move_speed * delta, Vector3.UP) #if the first ray cast is the player, it will start to move at the player
				$ShooterGhost/AnimationPlayer.play("GhostAnimation")
			else: #(animations)...
				$ShooterGhost/AnimationPlayer.play("GhostAnimation") 
		if can_shoot: #if it can shoot the player
			if $RayCast.get_collider() != null:
				if $RayCast.get_collider().name == "Player":
					Playerinfo.change_health(-15) #removes 15 health off the player
					$RayCast.get_collider().hit() #ouch player is hit
					print("yeet")
					SoundPlayer.play("res://Sounds/Sfx/Hitorhurt/001.wav") #plays hit sound
					
					
					if Playerinfo.get_health() <= 0: #if the player has no more health
						get_tree().reload_current_scene() #it will go back to the start of the level it is currently in
						Playerinfo.change_lives(-1) #it will remove a life
						Playerinfo.reset() #resets the player info (in code player.info)
						SoundPlayer.play("res://Sounds/Sfx/Explosion/Explosion_002.wav") 
			can_shoot = false
			$Timer.start() #short timer - so it won't spam and kill you in a millisecond


func _on_Area_body_entered(body): #checking the player when it enters the area of vision
	if body.name == "Player":
		$RayCast.set_enabled(true)
		print("gr found player")
		follow_player = true #sets variables to true
		can_shoot = true
		player = body




func _on_Area_body_exited(body):
	if body.name == "Player":
		$RayCast.set_enabled(false)
		print("wa lost player")
		follow_player = false #sets variables to false - out of reach
		can_shoot = false
	pass


func _on_Timer_timeout(): #timer finished, it can shoot at player again
	can_shoot = true
	pass # Replace with function body.
