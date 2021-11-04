extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bullet_speed = 2.5
var direction


# spawns the bullet and goes towarrds player
func _ready():
	var player_pos = get_parent().get_node("Player").global_transform.origin
	player_pos.y += 1
	var bullet_pos = global_transform.origin
	direction = player_pos - bullet_pos
	direction = direction.normalized()

func _process(delta):
	translate(direction * bullet_speed * delta)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
# pass


func _on_Area_body_entered(body):
	if body.filename != "res://Scenes/ShooterZombie.tscn":
		queue_free()
