extends Node

class_name Weapon

export var fire_rate = 0.5
export var clip_size = 5
export var reload_rate = 1

onready var ammo_label = $"/root/World/UI/Label"
onready var raycast = $"../Head/Camera/RayCast"
var current_ammo = 0
var can_fire = true
var reloading = false
var weapon_damage = 10

func _ready():
	current_ammo = clip_size


func _process(delta):
	if reloading:
		ammo_label.set_text("Reloading...")
	else:
		ammo_label.set_text("%d / %d" % [current_ammo, clip_size])
	
	if Input.is_action_just_pressed("primary_fire") and can_fire:
		#this code fire theweapon
		if current_ammo > 0 and not reloading: #checking if gun hasammo to shoot
			fire()
		elif not reloading: #if no ammo in gun it will reload
			reload()
			
	if Input.is_action_just_pressed("reload") and not reloading:
		reload()

func check_collision():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.is_in_group("Enemies"):
			collider.health -=50
			if collider.health <=0:
				collider.queue_free()
			print("Killed" + collider.name)

func fire():
	print("fired weapon")
	can_fire = false
	current_ammo -= 1
	check_collision()
	yield(get_tree().create_timer(fire_rate), "timeout")
		
	can_fire = true


func reload():
	
	reloading = true
	yield(get_tree().create_timer(reload_rate), "timeout")
	reloading = false
	current_ammo = clip_size
	print("Reload complete")
