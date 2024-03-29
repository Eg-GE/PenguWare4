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
		dist = transform.origin.distance_to(p.trash.transform.origin)
		p.targetvel = p.targetvel+remap(dist, 0, 3 , -1, 0)
		get_node("../Cell/Label").modulate.a = remap(p.targetsize,1,0.3,1,0)
		#print("we in there")
	else:
		dist = INF
		p.targetvel += 0.1
		
	p.targetvel = clamp(p.targetvel,-0.3,0.3)
	p.targetsize=p.targetsize + p.targetvel/50
	print(p.targetvel)
	p.targetsize = clamp(p.targetsize,.3,1)
	print(p.targetsize)
	var unsized = p.deftransform
	get_node("../Cell/Label").modulate.a = remap(targetsize,1,0.3,1,0)
	get_node("../Collision").transform = unsized.scaled(Vector3(targetsize,targetsize,targetsize))
	get_node("../Mesh").transform = unsized.scaled(Vector3(targetsize,targetsize,targetsize))
	pass
