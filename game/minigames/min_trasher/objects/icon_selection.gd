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

func _ready():
	selectobject.modulate.a = 0.0
	lineheight = fontsize * pixelsize
	print(lineheight)
	
	
func _process(delta):
	
	parentglobalpos = get_parent().global_transform.origin

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
	
	
func _on_rigidbody_input_event(camera, event, position, normal, shape_idx):
	
	pass 


func _on_rigidbody_mouse_entered():
	selectobject.modulate.a = .6
	
	
	pass 


func _on_rigidbody_mouse_exited():
	selectobject.modulate.a = 0.0
	
	pass 
