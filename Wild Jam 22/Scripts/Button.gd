extends Button


func _ready():
	pass
	
	
func _process(delta):
	if pressed:
		get_tree().change_scene("res://Scenes/LoadingScreen.tscn")
