extends Node3D
@onready var player = $Player

func _physics_process(delta):
	call_deferred("update_player_location")
	
func update_player_location():
	get_tree().call_group("enemies", "update_target_location", player.global_transform.origin)
