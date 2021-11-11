extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var weapon_damage = 14
var can_fire = true
var fire_rate = 1
onready var rays = [$RayCast,$RayCast1,$RayCast8,$RayCast2,$RayCast3,$RayCast4,$RayCast5,$RayCast6,$RayCast7]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("primary_fire") and can_fire:
		fire()
		
func fire():
	print("fired weapon")
	can_fire = false
	Playerinfo.change_ammo(-8)
	check_collision()
	check_hit()
	$ShotgunGood/AnimationPlayer.play("Reload") 
	yield(get_tree().create_timer(fire_rate), "timeout")
	can_fire = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func check_hit():
	if $RayCast.is_colliding():
		var collider = $RayCast.get_collider()
		if collider.is_in_group("Enemy"):
			$RayCast.get_collider().hit_zombie()

func check_collision():
	for ray in rays:
		if ray.is_colliding():

			var collider = ray.get_collider()

			if collider.is_in_group("Enemies"):
				print("damage enemy")
				collider.health -=weapon_damage 
			
#				$HealthBar3D.update(health, max_health) #MYCODDDDETEST
				if collider.health <=0:
					collider.queue_free()
