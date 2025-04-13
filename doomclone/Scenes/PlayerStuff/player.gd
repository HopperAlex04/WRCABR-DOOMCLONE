extends CharacterBody3D

var vel = Vector3()
var gravity = -30
var max_speed = 15
var mouse_sensitivity = 0.002
var health = 100
var hit
var tp

signal interact_pressed

#gun variables
var bolts = 100
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$health.text = str(health)
	hit = $Pivot/Temps/CanvasLayer/Control/Damage
	tp = $Pivot/Temps/CanvasLayer/Control/TP
	hit.color = Color8(232,71,60,0)
	tp.color = Color8(44,10,50,0)
	
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
	if Input.is_action_pressed("interact"):
		emit_signal("interact_pressed")
	return input_dir
		
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		#print("check")
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
	max_speed = 15
	pass

func _change_gun(_gun):
	pass
	
func _process(_delta):
	pass


func _on_player_entered(body: Node3D) -> void:
	if (body == self):
		tp.color = Color8(44,10,50,160)
		$dam_tpfilterTime.start()
	body.position.x = 290 
	body.position.y = 0.431
	body.position.z = 520

func _on_seeker_player_hit() -> void:
	health -= 10
	$health.text = str(health)
	hit.color = Color8(232,71,60,160)
	$dam_tpfilterTime.start()

func _on_dam_tpfilter_time_timeout() -> void:
	hit.color = Color8(232,71,60,0)
	tp.color = Color8(44,10,50,0)


func _on_charger_player_hit() -> void:
	health -= 15
	$health.text = str(health)
	hit.color = Color8(232,71,60,160)
	$dam_tpfilterTime.start() # Replace with function body.


func _on_health_pot_pickup(body) -> void:
	if (body == self):
		health += 5
		$health.text = str(health) # Replace with function body.


func _on_ammo_pickup_pickup(body) -> void:
	if (body == self):
		#print("pickup")
		$Pivot/Gun/Pistol/Ammo.count += 5
		$Pivot/Gun/Pistol/Ammo.text = str($Pivot/Gun/Pistol/Ammo.count) # Replace with function body.


func _on_node_3d_2_player_hit() -> void:pass# Replace with function body.


func _on_boss_player_hit() -> void:
	health -= 20
	$health.text = str(health)
	hit.color = Color8(232,71,60,160)
	$dam_tpfilterTime.start() # Replace with function body.
