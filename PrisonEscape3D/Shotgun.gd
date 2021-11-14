extends Spatial


# Declared variables here
var weapon_damage = 35
var can_fire = true
var fire_rate = 1
onready var rays = [$RayCast,$RayCast1,$RayCast8,$RayCast2,$RayCast3,$RayCast4,$RayCast5,$RayCast6,$RayCast7]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("primary_fire") and can_fire: #if it can fire...
		if can_fire: 
			if Playerinfo.ammo > 8: #When out of ammo it wouldn't shoot
				fire() #it will fire and play fancy shotgun sound
				SoundPlayer.play("res://Sounds/Sfx/LaserorShoot/Laser_001.wav")
			else:
				SoundPlayer.play("res://Sounds/Sfx/Hitorhurt/004.wav")
				print("No shotammo") #no ammo will play dud sound like AK does
				
func fire(): #if it can fire
	print("fired weapon")
	can_fire = false
	Playerinfo.change_ammo(-8) #will remove 8 bullets instead of 1, as shotgun = more powerful = more bullets used up
	check_collision()
	check_hit() #checks the collision and what it hit
	$ShotgunGood/AnimationPlayer.play("Reload") #will play the reload animation after evry shot
	yield(get_tree().create_timer(fire_rate), "timeout") #can't shoot at the time being - 1 secound ish
	can_fire = true #now time is up it can
	


func check_hit(): #checks the hit
	for ray in rays: #for the rays (how many rays actually hits collision) 
		if ray.is_colliding():#rays include all 8!!! so each one will deal damage 
			var collider = ray.get_collider()
			if collider.is_in_group("Enemy"): #checks if it is an emeie
				collider.hit_zombie() #will hit the zombie
				print("gottem") #check if it worked...
			else:
				pass #else it won't do anything if no rays hit


#bellow is the old code I was trying to do - seperately for each different ray.
#I wanted it so it was how many rays dealth that much damaage, not 1 ray deals ALL shot gun damge...
#bellow was too bulky and didn't work properly and I changed the code to above code
#	if $RayCast.is_colliding() or $RayCast1.is_colliding() or $RayCast2.is_colliding() or $RayCast3.is_colliding() or $RayCast4.is_colliding() or $RayCast5.is_colliding() or $RayCast6.is_colliding() or $RayCast7.is_colliding() or $RayCast8.is_colliding():
#		var collider = $RayCast.get_collider()
#		if collider.is_in_group("Enemy"):
#			#for $RayCast in $RayCast.is_colliding():
#			$RayCast.get_collider().hit_zombie()
#		else:
#			pass
#
#
#		if$RayCast1.is_colliding():
#			var collider1 = $RayCast1.get_collider()
#			if collider1.is_in_group("Enemy"):
#				#for $RayCast in $RayCast.is_colliding():
#				collider1.hit_zombie()
#			else:
#				pass
#
#		var collider2 = $RayCast2.get_collider()
#		if collider2.is_colliding():
#			if collider2.is_in_group("Enemy"):
#				#for $RayCast in $RayCast.is_colliding():
#				$RayCast2.get_collider().hit_zombie()
#			else:
#				pass
#
#		var collider3 = $RayCast3.get_collider()
#		if collider3.is_colliding():
#			if collider3.is_in_group("Enemy"):
#				#for $RayCast in $RayCast.is_colliding():
#				$RayCast3.get_collider().hit_zombie()
#			else:
#				pass
#
#		var collider4 = $RayCast4.get_collider()
#		if collider4.is_colliding():
#			if collider4.is_in_group("Enemy"):
#				#for $RayCast in $RayCast.is_colliding():
#				$RayCast4.get_collider().hit_zombie()
#			else:
#				pass
#
#		var collider5 = $RayCast5.get_collider()
#		if collider5.is_colliding():
#			if collider5.is_in_group("Enemy"):
#				#for $RayCast in $RayCast.is_colliding():
#				$RayCast5.get_collider().hit_zombie()
#			else:
#				pass
#
#		var collider6 = $RayCast6.get_collider()
#		if collider6.is_colliding():
#			if collider6.is_in_group("Enemy"):
#				#for $RayCast in $RayCast.is_colliding():
#				$RayCast6.get_collider().hit_zombie()
#			else:
#				pass
#
#		var collider7 = $RayCast7.get_collider()
#		if collider7.is_colliding():
#			if collider7.is_in_group("Enemy"):
#				#for $RayCast in $RayCast.is_colliding():
#				$RayCast7.get_collider().hit_zombie()
#			else:
#				pass
#
#		var collider8 = $RayCast8.get_collider()
#		if collider8.is_colliding():
#			if collider8.is_in_group("Enemy"):
#				#for $RayCast in $RayCast.is_colliding():
#				$RayCast8.get_collider().hit_zombie()
#			else:
#				pass


func check_collision(): #checks the collision
	for ray in rays: #used similar method here 
		if ray.is_colliding():
			var collider = ray.get_collider()

			if collider.is_in_group("Enemies"):
				print("damage enemy")
				collider.health -=weapon_damage 
			
#				$HealthBar3D.update(health, max_health) #MYCODDDDETEST
				if collider.health <=0:
					collider.queue_free()
