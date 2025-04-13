extends Node3D
signal pickup
func _on_area_3d_body_entered(body: Node3D) -> void:
	emit_signal("pickup", body)
	self.queue_free() # Replace with function body.
