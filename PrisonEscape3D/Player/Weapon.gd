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

func _ready():
	current_ammo = clip_size
	if reloading:
		ammo_label.set_text("Reloading...")
		
func _process(delta):
	ammo_label.set_text("%d / %d" % [current_ammo, clip_size])
	if Input.is_action_just_pressed("primary_fire") and can_fire:
		#this code fire theweapon
		if current_ammo > 0 and not reloading: #checking if gun hasammo to shoot
			print("fired weapon")
			can_fire = false
			current_ammo -= 1
			check_collision()
			yield(get_tree().create_timer(fire_rate), "timeout")
			
			can_fire = true
		elif not reloading: #if no ammo in gun it will reload
			reloading = true
			yield(get_tree().create_timer(reload_rate), "timeout")
			reloading = false
			current_ammo = clip_size
			print("Reload complete")
			
func check_collision():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.is_in_group("Enemies"):
			collider.queue_free()
			print("Killed" + collider.name)
