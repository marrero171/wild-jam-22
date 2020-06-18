extends VehicleBody

export var color = Color(0,0,0)

export var Player = false

func _ready():
	$Parts/Body/Body.mesh.get("surface_1/material").set("albedo_color", color)
	$Parts/HeadlightFrames/HeadlightFrames.mesh.get("surface_1/material").set("albedo_color", color)
	
func _physics_process(_delta):
	
	if Player:
		if Input.is_action_just_pressed("Camera"):
			$ThirdPerson.current = not($ThirdPerson.current)
		
		if $ThirdPerson.current:
			$FirstPerson.current = false
		else:
			$FirstPerson.current = true
		
		if Input.is_action_pressed("ui_up"):
			set_engine_force(5000.0)
		print(engine_force)
