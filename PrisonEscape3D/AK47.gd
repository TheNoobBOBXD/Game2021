extends Spatial


var weapon_damage = 29
var can_fire = true
var fire_rate = 0.11
# Called when the node enters the scene tree for the first time.
onready var ray = [$RayCast]

func _ready():
	pass

func _process(_delta):
	if Input.is_action_pressed("primary_fire") and can_fire:
		$AK47Good/AnimationPlayer.play("Shoot")
		fire()
	if Input.is_action_just_released("primary_fire"):
		$AK47Good/AnimationPlayer.stop()
	
		
func fire():
	print("fired weapon")
	can_fire = false
	Playerinfo.change_ammo(-1)
	check_collision()
	check_hit()
	$AK47Good/AnimationPlayer.play("Reload")
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
	if $RayCast.is_colliding():
		var collider = $RayCast.get_collider()
		
		if collider.is_in_group("Enemies"):
			print("damage enemy")
			collider.health -=weapon_damage
			if collider.health <=0:
				collider.queue_free()
