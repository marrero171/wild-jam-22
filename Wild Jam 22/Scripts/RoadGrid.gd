extends GridMap

onready var tilemap = get_parent().get_node("CanvasLayer/Minimap")
onready var calculatetile = get_parent().get_node("CanvasLayer/CalculateTile")
onready var Car = get_parent().get_node("VehicleBody")
onready var vehiclepoint = tilemap.get_node("Sprite")

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

func miniMap(arr):
	for x in arr.size():
		for y in arr[x].size():
			if arr[x][y] == null:
				arr[x][y] = -1
			tilemap.set_cell(x,y,arr[x][y])
	tilemap.update_bitmask_region(Vector2(0,0), Vector2(arr.size(),arr[0].size()))

func convertToGrid(gridarr):
	for x in gridarr.size():
		for y in gridarr[x].size():
			match calculatetile.get_cell_autotile_coord(x,y):
				TWOD.straight:
					gridarr[x][y] = THREED.straight
				TWOD.straight_left:
					if calculatetile.get_cell(x,y) == TWOD.grass: #As Grass shares the same ID as straight_left; 0
						gridarr[x][y] = THREED.grass
					elif calculatetile.get_cell(x,y) == -1: #Empty cells give (0,0) when checked for autotile coords
						pass
					else:
						gridarr[x][y] = THREED.straight_left
				TWOD.curve_topleft:
					gridarr[x][y] = THREED.curve_topleft
				TWOD.curve_topright:
					gridarr[x][y] = THREED.curve_topright
				TWOD.curve_bottomleft:
					gridarr[x][y] = THREED.curve_bottomleft
				TWOD.curve_bottomright:
					gridarr[x][y] = THREED.curve_bottomright
	
	#print(arr)
	return gridarr

func loadTile(arr = Global.RoadGrid):
	for x in arr.size():
		for y in arr[x].size():
			calculatetile.set_cell(x,y,arr[x][y])
			calculatetile.update_bitmask_region(Vector2(0,0), Vector2(arr.size(),arr[0].size()))

func loadGrid(arr = Global.RoadGrid, mini = Global.minimap):
	for x in arr.size():
		for y in arr[x].size():
			#if arr[x][y] != -1:
				#print("x:"+str(x)+",y:"+str(y)+",id:"+str(arr[x][y]))
			set_cell_item(x,0,y,arr[x][y])
	

func _ready():
	miniMap(Global.minimap)
	loadTile()
	convertToGrid(Global.RoadGrid)
	loadGrid()
	
	#print(get_cell_item(0,0,0))
	#set_cell_item(0,0,0,4)
	#set_cell_item(1,0,0,5)
	#set_cell_item(0,0,1,0)
	#set_cell_item(1,0,1,3)
	#set_cell_item(0,0,2,6)

func _physics_process(delta):
	var coord = world_to_map(Car.translation)
	vehiclepoint.position = tilemap.map_to_world(Vector2(coord.x, coord.z))
	vehiclepoint.position += Vector2(15,15) #15 is half the size of the tile, to put the point in the middle of the tile
