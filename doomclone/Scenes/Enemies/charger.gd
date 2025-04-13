extends CharacterBody3D

@onready var nav = $NavigationAgent3D

var speed = 5
var health = 20
var dead = false
var charging = false
signal player_hit

func _ready() -> void:
	$Timer.start()

func _physics_process(_delta):
	var current_location = global_transform.origin
	var next_location = nav.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * speed
	look_at(nav.target_position)
	if nav.distance_to_target() < 3 and charging:
		charging = false
		emit_signal("player_hit")
	if is_on_floor() or new_velocity.y <= -4:
		new_velocity.y = -.1
	#print(new_velocity.y)
	set_velocity(new_velocity)
	$AnimatedSprite3D.play("Walk")
	move_and_slide()

func update_target_location(target_location):
	if !dead:
		set_process(true)
		set_physics_process(true)
		nav.target_position = target_location
	#else:
		#set_process(false)
		#set_physics_process(false)
		#nav.target_position = target_location
	
		#print(nav.distance_to_target())
	
func take_damage(dmg_amount):
	health -= dmg_amount
	$AnimatedSprite3D.play("hit")
	if health <= 0:
		death()
	

func death():
	set_process(false)
	set_physics_process(false)
	$CollisionShape3D.disabled = true
	dead = true
	$AnimatedSprite3D.play("explode")
	
func charge():
	#print("freshCall")
	speed = 20
	$ChargeTime.start()
	charging = true
	#await $AnimatedSprite3D.animation_finished
	#$Timer.start()
	#set_process(true)
	#set_physics_process(true)


func _on_timer_timeout() -> void:
	#print("timeout")
	charging = false
	if global_transform.origin.distance_to(nav.target_position) > 10 and !dead:
		charge()


#func _on_animated_sprite_3d_animation_finished() -> void:
	#print("timeout")
	#if !dead:
		#set_process(true)
		#set_physics_process(true) # Replace with function body.


func _on_charge_time_timeout() -> void:
	speed = 5 # Replace with function body.
