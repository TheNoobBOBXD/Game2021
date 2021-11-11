extends KinematicBody
#11.48 need to fix player
var player
var follow_player = false
var move_speed = 50
var can_shoot = false
var health = 10

onready var bullet = preload("res://EnemyBullet.tscn")#load bullet scene here


func _ready():
	pass

func hit_zombie():
	health -= 1
	if health <= 0:
		queue_free()



func _physics_process(delta):
	if follow_player == true:
		var pos = player.global_transform.origin
		var facing = -global_transform.basis.z
		look_at(pos, Vector3.UP)
		if $RayCast.get_collider() != null:
			if $RayCast.get_collider().name == "Player":
				move_and_slide(facing * move_speed * delta, Vector3.UP)
				$ShooterGhost/AnimationPlayer.play("GhostAnimation")
			else:
				$ShooterGhost/AnimationPlayer.play("GhostAnimation")
		if can_shoot:
			if $RayCast.get_collider() != null:
				if $RayCast.get_collider().name == "Player":
					Playerinfo.change_health(-15)
					$RayCast.get_collider().hit()
					print("yeet")
					if Playerinfo.get_health() <= 0:
						get_tree().reload_current_scene()
						Playerinfo.change_lives(-1)
						Playerinfo.reset()
						
			can_shoot = false
			$Timer.start()


func _on_Area_body_entered(body):
	if body.name == "Player":
		$RayCast.set_enabled(true)
		print("gr found player")
		follow_player = true
		can_shoot = true
		player = body




func _on_Area_body_exited(body):
	if body.name == "Player":
		$RayCast.set_enabled(false)
		print("wa lost player")
		follow_player = false
		can_shoot = false
	pass


func _on_Timer_timeout():
	can_shoot = true
	pass # Replace with function body.
