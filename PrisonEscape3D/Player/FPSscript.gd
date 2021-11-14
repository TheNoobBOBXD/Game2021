extends KinematicBody

#Variables for the player
#var speed
#export var sprint_speed = 20
#export var default_speed = 10
export var speed = 20
export var acceleration = 5
export var gravity = 1.98
export var jump_power = 30
export var mouse_sensitivity = 0.18
 
#onready var spark = preload("res://Particles/Spark.tscn") #the prelaoded spark I removed

onready var head = $Head
onready var camera = $Head/Camera

var velocity = Vector3()
var camera_x_rotation = 0 #orignial camera looking straight ahead.

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

#when the mouse moves, it stops if u look straight down or straight up 90 degrees. (can't break neck
func _input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))  #makes the camera move according to mouse sensitivity as well.

		var x_delta = event.relative.y * mouse_sensitivity 
		if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90:  #stops the camera moving over 180 (can't do a flip)
			camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta

func check_hit(): #checks if the Enemy has been hit 
	if $Head/Camera/RayCast.is_colliding():
		var collider = $Head/Camera/RayCast.get_collider()
		if collider.is_in_group("Enemy"): #(all enemies are in a group called 'Enemy' 
			$Head/Camera/RayCast.get_collider().hit_zombie() #calls out that it hit the zombie
#		else: 
#I decided not to add a spark when it hit the wall... it didn't look that nice and didn't suit my game. Therfor I removed it
#			var a = spark.instance()
#			a.global_transform.origin = $Head/Camera/Raycast.get_collision_point()
#			a.set_emitting(true)
#			print("sparky")



func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"): #escape button - will show  the mouse so you can exit the game
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_just_pressed("ui_accept"): #if space, enter or any ui_accept function is pressed, it will rejoin back into the game
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) 

func _physics_process(delta):
	
	#speed = default_speed
	
	var head_basis = head.get_global_transform().basis
	#basic movement of the player, put the pluggins for movement as 'wasd' system
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
	#how fast the player moves, 
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	velocity.y -= gravity
	#the jump code will only work if the player is on a floor
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_power
	
	velocity = move_and_slide(velocity, Vector3.UP)
	

	#checking is crtl is pressed for crouch function
	if Input.is_action_just_pressed("crouch"):
		crouch(delta)
	if Input.is_action_just_released("crouch"):
		uncrouch(delta)

#when crouch is pressed
func crouch(delta):
	print("crouch")
	$CollisionShape.shape.height = 0.75 #makes it smaller - crouching like
	speed = 6.9 #~~memes~~ moves slower 
	mouse_sensitivity = 0.15 #look around slower
	jump_power = 15 #can't jump as well 

func uncrouch(delta):
	print("uncrouch")
	$CollisionShape.shape.height = 1.25
	speed = 20
	mouse_sensitivity = 0.18
	jump_power = 30

func hit():
	$Head/Camera/ColorRect.show() #the flashing red when you get hit
	$Head/Camera/Timer.start() #the timer for this - then bellow it hides it

func _on_Timer_timeout():
	 $Head/Camera/ColorRect.hide()


func _on_Area_body_entered(body):
	if body.filename == "res://MYcreations/Medpack.tscn": #for the health pack, checking this as I wanted variable to be different from ammo
		SoundPlayer.play("res://Sounds/Sfx/Random/Randomize9.wav") #cool pick up noise is played
		Playerinfo.change_health(rand_range(10,25)) #randomly gives player a health between 10 and 25
		body.queue_free() #removes health pack
	if body.filename == "res://MYcreations/AmmoCrate.tscn": #same as above, but for ammo crate
		SoundPlayer.play("res://Sounds/Sfx/Random/Randomize9.wav")
		Playerinfo.change_ammo(42) #fixed 42 bullets lol
		body.queue_free() #removes the ammo crate.

