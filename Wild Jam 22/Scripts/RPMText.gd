extends Label


func _process(_delta):
	text = "REVOLUTIONS per seconds (RPM): " + str(Global.rpm)
