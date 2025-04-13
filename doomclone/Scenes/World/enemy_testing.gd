extends Node3D
@onready var player = $Player

func _physics_process(_delta):
	call_deferred("update_player_location")
	
func update_player_location():
	get_tree().call_group("Enemy", "update_target_location", player.global_transform.origin)

func _on_doortrigger_1_body_entered(body: Node3D) -> void:
	if (body == $Player) && $Door01 != null:
		var i = 0
		while i < 100:
			$Timer.start()
			await $Timer.timeout
			i += 1
			$Door01.position.y -= 0.1
		$Door01.queue_free()


func _on_doortrigger_2_body_entered(body: Node3D) -> void:
	if (body == $Player) && $Door05 != null:
		var i = 0
		while i < 100:
			$Timer.start()
			await $Timer.timeout
			i += 1
			$Door05.position.y -= 0.1
		$Door05.queue_free() # Replace with function body.


func _on_doortrigger_3_body_entered(body: Node3D) -> void:
	if (body == $Player) && $Door02 != null && $Door03 != null:
		var i = 0
		while i < 100:
			$Timer.start()
			await $Timer.timeout
			i += 1
			$Door02.position.y -= 0.1
			$Door03.position.y -= 0.1
		$Door02.queue_free()
		$Door03.queue_free() # Replace with function body.


func _on_area_3d_2_body_entered(body: Node3D) -> void:
	if (body == $Player) && $Door06 != null && $Door07 != null && $Door08 != null:
		var i = 0
		while i < 100:
			$Timer.start()
			await $Timer.timeout
			i += 1
			if $Door06 != null && $Door07 != null && $Door8 != null:
				$Door06.position.y -= 0.1
				$Door07.position.y -= 0.1
				$Door08.position.y -= 0.1
		$Door06.queue_free()
		$Door07.queue_free()
		$Door08.queue_free()
		
