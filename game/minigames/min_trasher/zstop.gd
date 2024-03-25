extends RigidBody3D

var lock_position : float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass
	
func _integrate_forces(state):
	#state.transform = Transform3D(global_basis, state.transform.origin * Vector3(1,1,0))
	var pos = state.transform.origin
	var vel = state.linear_velocity
	state.linear_velocity.z = 0
	state.transform.origin.z = 0
