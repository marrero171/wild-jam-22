extends Node

var rpm = 0

var playerColor = Color(0,0,0)

var RoadGrid = []
var minimap = []
var spawnPoint = Vector2.ZERO

var debug = true



func _ready():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("Fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	if Input.is_action_just_pressed("Restart") and debug:
		restart()


func restart():
	get_tree().reload_current_scene()
