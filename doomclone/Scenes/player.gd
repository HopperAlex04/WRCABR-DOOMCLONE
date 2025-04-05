extends CharacterBody3D

var vel = Vector3()
var gravity = -30
var max_speed = 11
var mouse_sensitivity = 0.002
var health = 100

#gun variables
var bolts = 100
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func get_input():
	var input_dir = Vector3()
	if Input.is_action_pressed("move_forward"):
		input_dir += -global_transform.basis.z
		#print("wrecieved")
	if Input.is_action_pressed("move_back"):
		input_dir += global_transform.basis.z
		#print("srecieved")
	if Input.is_action_pressed("strafe_left"):
		input_dir += -global_transform.basis.x
		#print("lrecieved")
	if Input.is_action_pressed("strafe_right"):
		input_dir += global_transform.basis.x
		#print("rrecieved")
	return input_dir
		
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -1.2, 1.2)
	
func _physics_process(delta):
	#gravity
	#vel.y += gravity * delta
	vel.y = 0
	var desired_velocity = get_input() * max_speed
	vel.x = desired_velocity.x
	vel.z = desired_velocity.z
	set_velocity(vel)
	move_and_slide()
	max_speed = 8
	pass

func _change_gun(_gun):
	pass
	
func _process(_delta):
	pass
