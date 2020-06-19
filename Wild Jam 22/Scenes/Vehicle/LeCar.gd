extends VehicleBody

export var color = Color(0,0,0)

export var Player = false

const ENGINE_FORCE = 5000.0
const BRAKE_FORCE = 75.0
const STEER_ANGLE = 0.5



func _ready():
	$Parts/Body/Body.mesh.get("surface_1/material").set("albedo_color", color)
	$Parts/HeadlightFrames/HeadlightFrames.mesh.get("surface_1/material").set("albedo_color", color)
	
func _physics_process(_delta):
	var forcef = 0
	var brakef = 0
	var steerf = 0
	
	if Player:
		if Input.is_action_just_pressed("Camera"):
			$ThirdPerson.current = not($ThirdPerson.current)
		
		if $ThirdPerson.current:
			$FirstPerson.current = false
		else:
			$FirstPerson.current = true
		
		if Input.is_action_pressed("ui_up"):
			forcef = 1
		if Input.is_action_pressed("ui_down"):
			forcef = -1
		if Input.is_action_pressed("ui_left"):
			steerf = 1
		if Input.is_action_pressed("ui_right"):
			steerf = -1
		if Input.is_action_pressed("Brake"):
			brakef = 1
		
		Global.rpm = round(-$Left_Front.get_rpm())
		if Global.rpm == -0:
			Global.rpm = 0
		
		engine_force = forcef * ENGINE_FORCE
		brake = brakef * BRAKE_FORCE
		steering = steerf * STEER_ANGLE
		
		print(Global.rpm)
