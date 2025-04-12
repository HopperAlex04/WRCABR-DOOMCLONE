extends Node3D


func _on_player_interact_pressed() -> void:
	var i = 0
	while i < 30:
		$Timer.start()
		await $Timer.timeout
		i += 0.01
		position.y -= 0.01
