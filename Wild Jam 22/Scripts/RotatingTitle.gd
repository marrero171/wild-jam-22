extends MeshInstance


var leftright

func _ready():
	randomize()
	leftright = randi()%2
	

func _physics_process(delta):
	if leftright == 0:
		leftright = -1

	rotation.y += leftright * 0.01
