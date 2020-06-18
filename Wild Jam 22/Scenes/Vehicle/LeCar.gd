extends VehicleBody

export var color = Color(0,0,0)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$StaticBody/Body/Body.mesh.get("surface_1/material").set("albedo_color", color)
	$StaticBody/HeadlightFrames/HeadlightFrames.mesh.get("surface_1/material").set("albedo_color", color)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass
