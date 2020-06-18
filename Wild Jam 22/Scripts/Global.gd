extends Node

var rpm = 0

func _ready():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("Fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
