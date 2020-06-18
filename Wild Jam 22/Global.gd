extends Node


func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("Fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
