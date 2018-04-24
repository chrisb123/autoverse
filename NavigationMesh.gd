extends NavigationMeshInstance

var vertices = PoolVector3Array()

func _ready():
	print("navigationMesh")
	for x in range(-10,10):
		for y in range(-10,10):
			vertices.append(Vector3(x,1,y)) #create a -10 to 10 grid
	navmesh.set_vertices(vertices) #add grid to nav mesh
	get_parent().navmesh_add(self,Transform(Vector3(1,0,0),Vector3(0,1,0),Vector3(0,0,1),Vector3(0,0,0))) #add navmesh to navigation