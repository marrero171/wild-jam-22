extends Label

var dots = 3


func _ready():
	pass


func _physics_process(delta):
	pass


func _on_dotTimer_timeout():
	dots += 1
	
	if dots == 4:
		dots = 0
	
	text = "LOADING" + (".".repeat(dots))
	
	$dotTimer.start()
