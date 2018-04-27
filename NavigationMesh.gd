extends NavigationMeshInstance

var vertices = PoolVector3Array()
var pia = PoolIntArray()
var tf = Transform()

func _ready():
	print("navigationMesh")
#	for x in range(-10,10):
#		for y in range(-10,10):
#			vertices.append(Vector3(x,1,y)) #create a -10 to 10 grid
#	navmesh.set_vertices(vertices) #add grid to nav mesh
#	get_parent().navmesh_add(self,Transform(Vector3(1,0,0),Vector3(0,1,0),Vector3(0,0,1),Vector3(0,0,0))) #add navmesh to navigation
	
	pia.append(-10)
	pia.append(1)
	pia.append(-10)
	
	pia.append(-10)
	pia.append(1)
	pia.append(10)
	
	pia.append(10)
	pia.append(1)
	pia.append(10)
	
	pia.append(10)
	pia.append(1)
	pia.append(-10)
	
	pia.append(-10)
	pia.append(1)
	pia.append(-10)
	
	print(navmesh.get_polygon_count())
	navmesh.add_polygon(pia)
	get_parent().navmesh_add(navmesh,tf)
#	tf.translated(Vector3(2,3,4))
#	get_parent().navmesh_add(navmesh,tf)
	print(navmesh.get_polygon_count())
	