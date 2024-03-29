extends Node

var act = true

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("../../../..").emit_signal("gravity_change",0)
	get_parent().gravity_scale = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(act):
		get_node("../../../..").emit_signal("gravity_change",0)
	elif(!act):
		get_node("../../../..").emit_signal("gravity_change",1)
	pass
