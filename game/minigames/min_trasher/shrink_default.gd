extends "res://game/minigames/min_trasher/icon_physics.gd"

var p
func _process(delta):
	pass
	
func _ready():
	p = get_parent()
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
	p.targetvel = clamp(p.targetvel,-0.3,0.3)
	p.targetsize=p.targetsize + p.targetvel/50
	
	p.targetsize = clamp(p.targetsize,.3,1)
	#print(p.trash)
	var unsized = p.deftransform
	get_node("../Cell/Label").modulate.a = remap(p.targetsize,1,0.3,1,0)
	get_node("../Collision").transform = unsized.scaled(Vector3(p.targetsize,p.targetsize,p.targetsize))
	get_node("../Mesh").transform = unsized.scaled(Vector3(p.targetsize,p.targetsize,p.targetsize))
	
	#if get_node("../Pin") is PinJoint3D:
	#	print("fuck it we ball")
		#p.pinpoint.transform = p.pinpoint.transform.interpolate_with(get_node("../Mesh").transform,p.targetsize)
		#var gug = to_global(p.pinpoint.transform.origin)
		#p.pinpoint.position = p.mousepos3 
	pass
