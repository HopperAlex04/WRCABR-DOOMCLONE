extends CharacterBody3D

@onready var nav = $NavigationAgent3D

var speed = 5
var health = 20

func _ready() -> void:
	$Timer.start()

func _physics_process(_delta):
	var current_location = global_transform.origin
	var next_location = nav.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * speed
	look_at(nav.target_position)
	if is_on_floor() or new_velocity.y <= -4:
		new_velocity.y = -.1
	#print(new_velocity.y)
	set_velocity(new_velocity)
	$AnimatedSprite3D.play("Walk")
	move_and_slide()

func update_target_location(target_location):
	if global_transform.origin.distance_to(nav.target_position) > 15:
		set_process(true)
		set_physics_process(true)
		nav.target_position = target_location
	else:
		set_process(false)
		set_physics_process(false)
		nav.target_position = target_location
	
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
	if health < -20:
		$AnimatedSprite3D.play("explode")
	else:
		$AnimatedSprite3D.play("Die")
	
func shoot():
	#print("freshCall")
	set_process(false)
	set_physics_process(false)
	$AnimatedSprite3D.play("shoot")
	await $AnimatedSprite3D.animation_finished
	print(get_tree().get_first_node_in_group("Player"))
	print($RayCast3D.get_collider())
	if $RayCast3D.is_colliding() and $RayCast3D.get_collider() == get_tree().get_first_node_in_group("Player"):
		print("hit")
	#await $AnimatedSprite3D.animation_finished
	#$Timer.start()
	#set_process(true)
	#set_physics_process(true)


func _on_timer_timeout() -> void:
	#print("timeout")
	if global_transform.origin.distance_to(nav.target_position) < 15:
		shoot()


func _on_animated_sprite_3d_animation_finished() -> void:
	#print("timeout")
	set_process(true)
	set_physics_process(true) # Replace with function body.
