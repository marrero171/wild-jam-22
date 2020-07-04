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
		
	if Input.is_action_just_pressed("escape"):
		if get_parent().has_node("Title"):
			get_tree().quit()
			
		else:
			Engine.iterations_per_second = 60
			get_tree().change_scene("res://Scenes/TitleScreen.tscn")
		

func restart():
	get_tree().reload_current_scene()
