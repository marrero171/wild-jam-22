extends VehicleBody

export var color = Color(0,0,0)

export var Player = false

func _ready():
	$StaticBody/Body/Body.mesh.get("surface_1/material").set("albedo_color", color)
	$StaticBody/HeadlightFrames/HeadlightFrames.mesh.get("surface_1/material").set("albedo_color", color)
	
func _physics_process(_delta):
	
	if Player:
		if Input.is_action_just_pressed("Camera"):
			$ThirdPerson.current = not($ThirdPerson.current)
		
		if $ThirdPerson.current:
			$FirstPerson.current = false
		else:
			$FirstPerson.current = true
