extends KinematicBody
#11.48 need to fix player
var player
var follow_player = false
var move_speed = 200



func _ready():
	pass



func _physics_process(delta):
	if follow_player == true:
		var pos = player.global_transform.origin
		look_at(pos, Vector3.UP)
		var facing = -global_transform.basis.z
		
		if $RayCast.get_collider() != null:
			if $RayCast.get_collider().name == "Player":
				move_and_slide(facing * move_speed * delta, Vector3.UP)
				$Ghost/AnimationPlayer.play("GhostAttack001")
			else:
				$Ghost/AnimationPlayer.play("GhostAnimation")
			
		
		


func _on_Area_body_entered(body):
	if body.name == "Player":
		$RayCast.set_enabled(true)
		print("found player")
		follow_player = true
		player = body




func _on_Area_body_exited(body):
	if body.name == "Player":
		$RayCast.set_enabled(false)
		print("lost player")
		follow_player = false



