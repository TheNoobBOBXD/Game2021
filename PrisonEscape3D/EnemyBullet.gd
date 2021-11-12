extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bullet_speed = 2.5
var direction


# spawns the bullet and goes towarrds player
func _ready():
	
	var player_pos = get_parent().get_node("Player").global_transform.origin
	#player_pos.y += 1
	#look_at(player_pos,Vector3.UP)
	#var bullet_pos = global_transform.origin
	#direction = player_pos - bullet_pos
	#direction = direction.normalized()

func _process(_delta):
	pass
	#translate(-global_transform.basis.z * bullet_speed * delta)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
# pass


func _on_Area_body_entered(body):
	if not body.is_in_group("Enemy"):
		queue_free()
