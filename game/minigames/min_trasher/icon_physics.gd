extends RigidBody3D

@export var is_trash = false

var lock_position : float = 0

var pinpos = Vector3.ZERO
var pinfirst = Vector3.ZERO
var mousepos : Vector2 
var mousepos3 : Vector3 
var force : Vector3
var mousepressed : bool = false
var mousehover : bool = false
var selected : bool = false


var pinscene = load("res://game/minigames/min_trasher/objects/Pin.tscn")
var pin


var debug
var pinpoint
var pinpointscene = load("res://game/minigames/min_trasher/objects/pinpoint.tscn")

var trash

var deftransform = transform

var targetsize = 1
var targetvel = 0

var behaviour
var pinguh

func _ready():
	
	get_node("../../..").gravity_change.connect(on_gravity_change)
	behaviour=$Shrink
	
	debug = pinpointscene.instantiate()
	pinpoint = pinpointscene.instantiate()
	#add_child(debug)
	add_child(pinpoint)
	
	
	pin = pinscene.instantiate()
	
	pin.node_a = self.get_path()
	pin.node_b = pinpoint.get_path()
	pass 


func _process(delta):
	mousepos = (get_viewport().get_mouse_position() - get_viewport().get_visible_rect().size/2 ) * 0.01  
	mousepos3 = to_local(Vector3(mousepos.x,-mousepos.y,0)) 
	
	#debug.position = pinpos
	pinpoint.position = mousepos3
	
	#pinpos = to_local(pinfirst.lerp(Vector3.ZERO, targetsize))
	if $Pin is PinJoint3D:
		#print("AGE UEFPOAIS")
		$Pin.position = to_local(pinpos)*targetsize
		pinguh = $Pin
		
	#if freeze and get_contact_count()>0:
		#freeze=false
	
	#print(to_local(pinpos)*targetsize)
	behaviour._trash_shrink()
	#print(trash)
	
	pass
	
	
func _input_event(camera, event, po, normal, shape_idx):
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_action_pressed("mouse_left"):
		pinpos = to_local(po)
		#print(pinpos)
		pinfirst = pinpos
		mousepressed = true
		if mousehover:
			selected = true
			pin.position = pinpos
			add_child(pin)
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_action_released("mouse_left"):
		pinpos = Vector3.ZERO
		mousepressed = false
		selected=false
		remove_child(pin)
		
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if selected and not event.is_pressed():
			selected = false
			if get_node_or_null("Pin") != null:
				remove_child(get_node("Pin"))
			pass

func _mouse_enter():
	mousehover=true
func _mouse_exit():
	mousehover=false

func on_gravity_change(g):
	gravity_scale = g
	pass


#func _trash_shrink():
	#if !is_trash:
		#var dist
		#if trash != null:
			#dist = transform.origin.distance_to(trash.transform.origin)
			#targetvel = targetvel+remap(dist, 0, 3 , -1, 0)
			#$Cell/Selection.modulate.a = remap(targetsize,1,0.3,1,0)
			##print("we in there")
		#else:
			#dist = INF
			#targetvel += 0.1
			##print("we outie")
			#
		#targetvel = clamp(targetvel,-0.3,0.3)
		#targetsize=targetsize + targetvel/50
		##print(targetvel)
		#targetsize = clamp(targetsize,.3,1)
		##print(targetsize)
		#var unsized = deftransform
		#$Cell/Label.modulate.a = remap(targetsize,1,0.3,1,0)
		#$Collision.transform = unsized.scaled(Vector3(targetsize,targetsize,targetsize))
		#$Mesh.transform = unsized.scaled(Vector3(targetsize,targetsize,targetsize))
		#pass
		

func _integrate_forces(state):
	
	#state.linear_velocity.z = 0
	state.transform.origin.z = 0
