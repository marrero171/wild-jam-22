extends Button


func _ready():
	pass
	
func _process(_delta):
	if pressed:
		get_tree().change_scene("res://Worlds/WorldScene.tscn")
