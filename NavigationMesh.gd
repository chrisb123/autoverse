extends NavigationMeshInstance

var vertices = PoolVector3Array()
var pia1 = PoolIntArray()
var pia2 = PoolIntArray()
var tf = Transform()

func _ready():
	var nav_mesh = NavigationMesh.new()
	print("navigationMesh")
#	for x in range(-10,10):
#		for y in range(-10,10):
#			vertices.append(Vector3(x,1,y)) #create a -10 to 10 grid
#	navmesh.set_vertices(vertices) #add grid to nav mesh
#	get_parent().navmesh_add(self,Transform(Vector3(1,0,0),Vector3(0,1,0),Vector3(0,0,1),Vector3(0,0,0))) #add navmesh to navigation
#
#	pia1.append(-10)
#	pia1.append(1)
#	pia1.append(-10)
#
#	pia1.append(-10)
#	pia1.append(1)
#	pia1.append(10)
#
#	pia1.append(10)
#	pia1.append(1)
#	pia1.append(10)
#
#	pia2.append(-10)
#	pia2.append(1)
#	pia2.append(-10)
#
#	pia2.append(10)
#	pia2.append(1)
#	pia2.append(-10)
#
#	pia2.append(10)
#	pia2.append(1)
#	pia2.append(10)
#
#	nav_mesh.add_polygon(pia1)
#	nav_mesh.add_polygon(pia2)
		
	get_parent().navmesh_add(navmesh,tf)
	tf = tf.translated(Vector3(10,0,0))
	get_parent().navmesh_add(navmesh,tf)
#	print(navmesh.get_polygon_count())
	
#	var nav_mesh_inst = NavigationMeshInstance.new()
#	nav_mesh_inst.set_navigation_mesh(nav_mesh)
#	nav_mesh_inst.set_enabled(true)
#	get_parent().add_child(nav_mesh_inst)
	