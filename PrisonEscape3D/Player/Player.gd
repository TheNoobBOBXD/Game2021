extends KinematicBody

export var speed = 10
export var acceleration = 5
export var gravity = 0.98
export var jump_power = 25
export var mouse_sensitivity = 0.25
#NEW CODE
export var fire_rate = 0.3
export var clip_size = 20
export var reload_rate = 1



onready var head = $Head
onready var camera = $Head/Camera
onready var aimcast = $Head/Camera/AimCast
onready var muzzle = $Head/Gun/Muzzle


var damage = 100
var velocity = Vector3()
var camera_x_rotation = 0
#NEW CODE
var current_ammo = clip_size
var can_fire = true 
var reloading = false



func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)



func _input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		
		var x_delta = event.relative.y * mouse_sensitivity
		if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta <90:
			camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta



func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_just_pressed("fire"):
		if aimcast.is_colliding():
			var collision = aimcast.get_collider()
			#NEW CODE
			if collision:
				if current_ammo >0 and not reloading:
					can_fire =false
					current_ammo -=1	
					yield(get_tree().create_timer(fire_rate), "timeout")
					can_fire = true 
				#OLD CODE
					if collision.is_in_group("Enemy"):
						print("hit enemy")
						collision.health -= damage
				#NEW CODE
				elif not reloading:
					print("reloading")
					reloading=true 
					yield(get_tree().create_timer(reload_rate), "timeout")
					current_ammo = clip_size
					reloading = false 
					print("Reloading complete")



func _physics_process(delta):
	var head_basis = head.get_global_transform().basis
	
	var direction = Vector3()
	if Input.is_action_pressed("move_forward"):
		direction -= head_basis.z
	elif Input.is_action_pressed("move_backward"):
		direction += head_basis.z
		
	if Input.is_action_pressed("move_left"):
		direction -= head_basis.x
	elif Input.is_action_pressed("move_right"):
		direction += head_basis.x
		
	direction = direction.normalized() 
	
	velocity = velocity.linear_interpolate(direction*speed, acceleration * delta)
	velocity.y -= gravity
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_power
	velocity = move_and_slide(velocity, Vector3.UP)
	
