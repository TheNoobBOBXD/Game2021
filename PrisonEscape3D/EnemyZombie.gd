extends KinematicBody
#11.48 need to fix player



#was my first creation, didn't end up using this much


var player
var follow_player = false
var move_speed = 200
var can_shoot = false
var health = 2

onready var bullet = preload("res://EnemyBullet.tscn")#

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
				$Ghost/AnimationPlayer.play("GhostAttack001")
			else:
				$Ghost/AnimationPlayer.play("GhostAnimation")
		if can_shoot:
			if $RayCast.get_collider() != null:
				if $RayCast.get_collider().name == "Player":
					Playerinfo.change_health(-10)
					$RayCast.get_collider().hit()
					print("hoit")
			can_shoot = false
			
			$Timer.start()



func _on_Area_body_entered(body):
	if body.name == "Player":
		$RayCast.set_enabled(true)
		print("found player")
		follow_player = true
		can_shoot = true
		player = body




func _on_Area_body_exited(body):
	if body.name == "Player":
		$RayCast.set_enabled(false)
		print("lost player")
		follow_player = false
		can_shoot = false
	pass




func _on_Timer_timeout():
	can_shoot = true
	pass # Replace with function body.

