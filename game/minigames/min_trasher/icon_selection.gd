extends Node3D

@onready var meshobject : MeshInstance3D = get_parent().find_child("Mesh")
var meshglobalaabb : AABB
var ysize : float
var xsize : float
var xpos : float
var ypos : float

var xlpos : float
var ylpos : float
@onready var selectobject : Sprite3D = $Selection
@onready var labelobject : Label3D = $Label
@onready var pixelsize : float = labelobject.pixel_size
@onready var fontsize : int = labelobject.font_size

var parentglobalpos
var lineheight : float

var margin = Vector3(0.2,0.2,0)

enum State{
	NONE,
	HOVER,
	SELECTED,
	ACTIVE,
	TRASHED
}
var mousehover = false
var cellstate = State.NONE

func _ready():
	visualize_state()
	lineheight = fontsize * pixelsize
	
	var posit = Transform3D.IDENTITY.translated(Vector3(0,0,-1))
	transform = posit
	$Selection.transform = posit
	$Label.transform = posit
	
	
func _process(delta):
	
	parentglobalpos = get_parent().global_transform.origin
	
	if "shrink_aabb" in get_parent().find_child("Shrink"):
		meshglobalaabb = get_parent().find_child("Shrink").shrink_aabb
		
	else: 
		meshglobalaabb = meshobject.global_transform * meshobject.get_aabb()
	
	xsize = meshglobalaabb.size.x + (margin.x*2)
	ysize = meshglobalaabb.size.y + (margin.y*2) + lineheight
	xpos = parentglobalpos.x
	ypos = parentglobalpos.y - (ysize/2 - (margin.y + meshglobalaabb.size.y/2))
	
	
	xlpos = parentglobalpos.x 
	ylpos = parentglobalpos.y - meshglobalaabb.size.y/2
	
	
	labelobject.position.x = xlpos
	labelobject.position.y = ylpos
	
	selectobject.scale.x = xsize
	selectobject.scale.y = ysize
	
	position.x = xpos
	position.y = ypos

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if mousehover:
			_change_state(State.ACTIVE)
		else:
			_change_state(State.NONE)
	pass 
	
	
func _on_rigidbody_input_event(camera, event, position, normal, shape_idx):
	pass


func _on_rigidbody_mouse_entered():
	mousehover = true
	if cellstate == State.NONE:
		_change_state(State.HOVER)
	elif cellstate == State.SELECTED:
		_change_state(State.ACTIVE)
		
	pass 


func _on_rigidbody_mouse_exited():
	mousehover = false
	if cellstate == State.HOVER:
		_change_state(State.NONE)
	elif cellstate == State.ACTIVE:
		_change_state(State.SELECTED)
	pass 



func _change_state(s) :
	if cellstate != s :
		cellstate = s
		visualize_state()

func visualize_state():
	match cellstate:
		
		State.NONE:
			selectobject.modulate.a = 0.0
			
		State.HOVER:
			selectobject.modulate.a = .2
			
		State.SELECTED:
			selectobject.modulate.a = .76
			
		State.ACTIVE:
			selectobject.modulate.a = 1
			

