extends Spatial

#bunch of variables
var has_ammo = true
var weapon_damage = 29
var can_fire = true
var fire_rate = 0.11
# Called when the node enters the scene tree for the first time.
onready var ray = [$RayCast] 

func _ready():
	pass

func _process(_delta): #basic shooting, if has ammo and can fire it will
	if Input.is_action_pressed("primary_fire") and can_fire and has_ammo:
		if can_fire:
			if Playerinfo.ammo > 0: #this worked, when out of ammo it wouldn't shoot
				$AK47Good/AnimationPlayer.play("Shoot") #quick shooting animation
				fire()
				SoundPlayer.play("res://Sounds/Sfx/LaserorShoot/Shoot_001.wav") #plays shooting sound
			else:
				SoundPlayer.play("res://Sounds/Sfx/Hitorhurt/004.wav") #plays a dud sound (no ammo)
				print("No ammo") 
				yield(get_tree().create_timer(fire_rate), "timeout")
#	else: #code didn't work - tried another method
#		can_fire = false
#		has_ammo = false
#		stop_fire()
	if Input.is_action_just_released("primary_fire"):
		$AK47Good/AnimationPlayer.stop() #if the button is released it will stop - automatic gun

#was testing code for has ammo - if player doesn't have ammo can fire is false
func has_ammo():
	if Playerinfo.ammo() <=0:
		has_ammo = false
		can_fire = false
	else:
		can_fire = true
		has_ammo = true
		
#this also didn't work - from previous code so removed
#func stop_fire():
#	print("nofire")
#	can_fire = false
#	Playerinfo.change_ammo(0)
#
func fire():
	print("fired weapon")
	can_fire = false
	Playerinfo.change_ammo(-1)
	check_collision()
	check_hit()
	$AK47Good/AnimationPlayer.play("Reload")
	can_fire = false
	yield(get_tree().create_timer(fire_rate), "timeout")

	can_fire = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func check_hit(): #check when the ak is hit
	if $RayCast.is_colliding(): #if the ray from the gun is colliding...
		var collider = $RayCast.get_collider()
		if collider.is_in_group("Enemy"): #and it is in the group 'zombie' (enemy)
			$RayCast.get_collider().hit_zombie() #calls HIT ZOMBIE
			

func check_collision(): #cheking what it actually hit
	if $RayCast.is_colliding():
		var collider = $RayCast.get_collider()
		if collider.is_in_group("Enemies"):
			print("damage enemy")
			collider.health -=weapon_damage #does damge
			if collider.health <=0:
				collider.queue_free() #removes the coolider/zombie
