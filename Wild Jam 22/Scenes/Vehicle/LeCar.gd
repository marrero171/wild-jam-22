extends VehicleBody

export var color = Color(0,0,0)



func _ready():
	$StaticBody/Body/Body.mesh.get("surface_1/material").set("albedo_color", color)
	$StaticBody/HeadlightFrames/HeadlightFrames.mesh.get("surface_1/material").set("albedo_color", color)
	
func _physics_process(_delta):
	pass
