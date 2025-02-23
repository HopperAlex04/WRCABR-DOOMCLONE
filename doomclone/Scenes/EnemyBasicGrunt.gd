extends CharacterBody3D

@onready var nav = $NavigationAgent3D

var speed = 3
var health = 20

func _physics_process(delta):
	var current_location = global_transform.origin
	var next_location = nav.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * speed
	set_velocity(new_velocity)
	move_and_slide()

func update_target_location(target_location):
	nav.target_position = target_location
	
func take_damage(dmg_amount):
	health -= dmg_amount
	if health <= 0:
		death()
	

func death():
	set_process(false)
	set_physics_process(false)
	$CollisionShape.disabled = true
	if health < -20:
		$AnimatedSprite3D.play("explode")
	else:
		$AnimatedSprite3D.play("die")
	
func shoot():
	pass
