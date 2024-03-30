extends "res://game/minigames/min_trasher/icon_physics.gd"
var crumple_size = 2
var crumple_col
@onready var initial_aabb : AABB = get_node("../Mesh").get_aabb()
var shrink_aabb : AABB = AABB(Vector3.ONE,Vector3.ONE)
var p
func _process(delta):
	pass
	
func _ready():
	p = get_parent()
	crumple_col = get_node("../CrumpleCollision")
	pass

func _trash_shrink():
	var dist
	if p.trash != null:
		
		dist = p.global_transform.origin.distance_to(p.trash.global_transform.origin)
		p.targetvel = p.targetvel+remap(dist, 0, 3 , -1, 0)
		get_node("../Cell/Label").modulate.a = remap(p.targetsize,1,0.3,1,0)
		#print("we in there")
	else:
		dist = INF
		p.targetvel += 0.1
	#print(p)	
	#print(dist)
	p.targetvel = clamp(p.targetvel,-0.7,0.6)
	p.targetsize=p.targetsize + p.targetvel/50
	
	p.targetsize = clamp(p.targetsize,0,1)
	var inverse_targetsize = remap(p.targetsize,1,0,0,1)
	#print(p.trash)
	var unsized = p.deftransform
	var t3 = Vector3(p.targetsize,p.targetsize,p.targetsize)
	var it3 = Vector3(inverse_targetsize,inverse_targetsize,inverse_targetsize)
	get_node("../Cell/Label").modulate.a = p.targetsize
	get_node("../Collision").transform = unsized.scaled(t3)
	get_node("../Mesh").transform = p.defmeshtransform.scaled(it3*crumple_size+Vector3.ONE)
	var targetaabb = remap(inverse_targetsize,1,0,14,50)
	shrink_aabb.size = initial_aabb.size*Vector3(targetaabb,targetaabb,targetaabb)
	get_node("../Mesh").set("blend_shapes/Crumple",inverse_targetsize)
	crumple_col.transform = unsized.scaled(it3*2)
	
	
	#if get_node("../Pin") is PinJoint3D:
	#	print("fuck it we ball")
		#p.pinpoint.transform = p.pinpoint.transform.interpolate_with(get_node("../Mesh").transform,p.targetsize)
		#var gug = to_global(p.pinpoint.transform.origin)
		#p.pinpoint.position = p.mousepos3 
	pass
