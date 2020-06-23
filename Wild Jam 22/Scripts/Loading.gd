extends TileMap

var RoadTiles

var spawnpoint = Vector2.ZERO
var reachedspawn = false
var result

const TWOD = {
	"straight":Vector2(0,1),
	"straight_left":Vector2(0,0),
	"curve_topleft":Vector2(1,0),
	"curve_topright":Vector2(2,0),
	"curve_bottomleft":Vector2(1,1),
	"curve_bottomright":Vector2(2,1),
	"grass":1
}
const THREED = {
	"straight":5,
	"straight_left":6,
	"curve_topleft":0,
	"curve_topright":2,
	"curve_bottomleft":1,
	"curve_bottomright":3,
	"grass":4
}

func buildInvArray(x = 34, y = 20):
	#size is how many inventory slots there are, param is how many parameters per slot.
	
	var arr = []
	arr.resize(x) #Resizes the array to have "size" indexes
	
	for i in arr.size():
		arr[i] = []
		arr[i].resize(y)
		
	for i in x:
		arr[i][0] = TWOD.grass
		arr[i][y-1] = TWOD.grass
		
	for i in y:
		arr[0][i] = TWOD.grass
		arr[x-1][i] = TWOD.grass
		
	return arr

func visualizeArray(arr):
	for x in arr.size():
		for y in arr[x].size():
			if arr[x][y] == null:
				arr[x][y] = -1
			set_cell(x,y,arr[x][y])
		
func storeArray(arr):
	for x in arr.size():
		for y in arr[x].size():
			arr[x][y] = get_cell(x,y)
	
	return arr

func removeTiles(arr = [], tiletoremove = 1): #primarily to remove grass, for minimap

	for x in arr.size():
		for y in arr[x].size():
			if arr[x][y] == tiletoremove:
				print(arr[x][y])
				arr[x][y] = -1

	
	return arr


func checkPoint(arr, x, y, allowedTiles = 0):
	var tilesdetected = 0
	
	#if x+1 > arr.size() or y+1 > arr[0].size():
		
	
	if arr[x+1][y] != -1:
		if spawnpoint != Vector2(x+1,y):
			tilesdetected += 1
		else:
			reachedspawn = true
	if arr[x-1][y] != -1:
		if spawnpoint != Vector2(x-1,y):
			tilesdetected += 1
		else:
			reachedspawn = true
	if arr[x][y+1] != -1:
		if spawnpoint != Vector2(x,y+1):
			tilesdetected += 1
		else:
			reachedspawn = true
	if arr[x][y-1] != -1:
		if spawnpoint != Vector2(x,y-1):
			tilesdetected += 1
		else:
			reachedspawn = true
	
	if tilesdetected <= allowedTiles:
		return true
	else:
		return false
		
func randomint(from, to):
	randomize()
	return randi()% (to-from+1) + from 



func generateCourse():
	var arr = buildInvArray()

	while spawnpoint == Vector2.ZERO:
		spawnpoint = Vector2(randomint(0, arr.size()), randomint(0, arr[0].size()))
		if get_cellv(spawnpoint) != -1:
			spawnpoint = Vector2.ZERO
	print(spawnpoint)
	
	arr[spawnpoint.x][spawnpoint.y] = 0
	
	visualizeArray(arr)
	
	var selectedPoint = spawnpoint
	
	while not(reachedspawn):
		var XorY = randomint(0,1)
		var PosorNeg = randomint(0,1)
		
		if PosorNeg == 0:
			PosorNeg = -1
		
		if XorY == 0:
			if arr[selectedPoint.x + PosorNeg][selectedPoint.y] == -1:
				result = checkPoint(arr, selectedPoint.x + PosorNeg, selectedPoint.y)
				if result:
					selectedPoint = Vector2(selectedPoint.x + PosorNeg, selectedPoint.y)
			else:
				result = false
				
		if XorY == 1:
			if arr[selectedPoint.x][selectedPoint.y + PosorNeg] == -1:
				result = checkPoint(arr, selectedPoint.x, selectedPoint.y + PosorNeg)
				if result:
					selectedPoint = Vector2(selectedPoint.x, selectedPoint.y + PosorNeg)
			else:
				result = false
				
		if result:
			arr[selectedPoint.x][selectedPoint.y] = 0
			
		visualizeArray(arr)
		
func _ready():
	
	#generateCourse()
	RoadTiles = buildInvArray()
	
	RoadTiles = storeArray(RoadTiles)
	
	Global.RoadGrid = RoadTiles.duplicate(true)
	
	#breakpoint
	Global.minimap = removeTiles(RoadTiles.duplicate(true))
	
	#print(TWOD)
	#print(THREED)
	
	
	
	#print(TWOD)
	#print(THREED)
	
	#visualizeArray(RoadTiles)
	
	#get_tree().change_scene("res://Worlds/World.tscn")
	
	#print(get_cell_autotile_coord(0,0))
	#print(get_cell(0,0))

	#if get_cell_autotile_coord(0,0) == TWOD.straight:
	#	print("STRAIGHT")
		
	#set_cell(3,0,0)
	#set_cell(3,1,0)
	#set_cell(3,2,0)
	#set_cell(3,3,0)
	#set_cell(4,3,0)
	#set_cell(5,3,0)
	#update_bitmask_region(Vector2(3,0), Vector2(5,3))


