extends KinematicBody

export var gravity = 0.98 #mycode

export var speed = 500
var space_state
var target
var camera_x_rotation = 0 #my
var velocity = Vector3()#mycode
onready var blood = preload("res://Particles/Blood.tscn")

func _ready():
	space_state = get_world().direct_space_state

func _process(delta):
	if target:
		var result = space_state.intersect_ray(global_transform.origin, target.global_transform.origin)
		if result.collider.is_in_group("Player"):
			look_at(target.global_transform.origin, Vector3.UP)
			set_color_red()
			move_to_target(delta)
		else:
			set_color_green()
			
func _physics_process(delta):#mycode
	
	velocity.y -= gravity#mycode
	velocity = move_and_slide(velocity, Vector3.UP)#mycode


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		target = body
		print(body.name + " entered")
		set_color_red()

func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		target = null
		print(body.name + " exited")
		set_color_green()

func move_to_target(delta):
	var direction = (target.transform.origin - transform.origin).normalized()
	move_and_slide(direction * speed * delta, Vector3.UP)

func set_color_red():
	$MeshInstance.get_surface_material(0).set_albedo(Color(1, 0, 0))

func set_color_green():
	$MeshInstance.get_surface_material(0).set_albedo(Color(0, 1, 0))
