extends Node

var act = true
@onready var wp = get_node("../../../Scene/Wallpaper")
@onready var mesh = get_node("../Mesh")
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(act):
		wp.set("visible", true)
		wp.set("texture", mesh.get("mesh").get("surface_0/material").get("albedo_texture"))
	elif(!act):
		wp.set("visible", false)
	pass
