extends Label
var count = 100

func _ready():
	text = str(count)
	
func _on_pistol_bolt_shot() -> void:
	count -= 1
	text = str(count)
