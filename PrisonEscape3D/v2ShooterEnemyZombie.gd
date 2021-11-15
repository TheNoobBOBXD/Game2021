extends KinematicBody

var player
var follow_player = false
var move_speed = 369
var can_shoot = false
var health = 3

onready var bullet = preload("res://EnemyBullet.tscn")#load bullet scene here

onready var blood  = preload("res://Particles/Blood.tscn")

func _ready():
	pass

func hit_zombie():
	health -= 1
	if health <= 0:
		var a = blood.instance()
		a.global_transform = global_transform
		#a.global_transform.origin = $Raycast.get_collision_point()
		get_parent().add_child(a)
		a.set_emitting(true)
		print("splat")
		SoundPlayer.play("res://Sounds/Sfx/Hitorhurt/002.wav")
		queue_free()


#Basically the same as the other shooter, only different is the animation and sound efects
func _physics_process(delta):
	if follow_player == true:
		var pos = player.global_transform.origin
		var facing = -global_transform.basis.z
		look_at(pos, Vector3.UP)
		if $Charge.get_collider() != null:
			if $Charge.get_collider().name == "Player":
				move_and_slide(facing * move_speed * delta, Vector3.UP)
				$Ghost/AnimationPlayer.play("GhostAnimation")
			else:
				$Ghost/AnimationPlayer.play("GhostAnimation")
		if can_shoot:
			if $RayCast.get_collider() != null:
				if $RayCast.get_collider().name == "Player":
					Playerinfo.change_health(rand_range(-3,-8)) #I also made it deal a random number of damage since it charged right at you
					$RayCast.get_collider().hit()
					print("yeet")
					SoundPlayer.play("res://Sounds/Sfx/Hitorhurt/001.wav")
					
					
					if Playerinfo.get_health() <= 0:
						get_tree().reload_current_scene()
						Playerinfo.change_lives(-1)
						Playerinfo.reset()
						SoundPlayer.play("res://Sounds/Sfx/Explosion/Explosion_002.wav") #MAkes differnet sound
			can_shoot = false
			$Timer.start()


func _on_Area_body_entered(body):
	if body.name == "Player":
		$RayCast.set_enabled(true)
		print("hehe found player") #printed to check - different from other enemy
		follow_player = true
		can_shoot = true
		player = body




func _on_Area_body_exited(body):
	if body.name == "Player":
		$RayCast.set_enabled(false)
		print("boho lost player") #no longer can follow or shoot at the player
		follow_player = false
		can_shoot = false
	pass


func _on_Timer_timeout(): #decreased the timer, so can shoot is true faster
	can_shoot = true
	pass # Replace with function body.
