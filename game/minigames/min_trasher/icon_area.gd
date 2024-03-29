extends Area3D


func _ready() -> void:
	self.body_entered.connect(_on_Area_body_entered)
	self.body_exited.connect(_on_Area_body_exited)

func _on_Area_body_entered(body:Node) -> void:
	if body is RigidBody3D:
		body.trash = self
		
	pass
	
func _on_Area_body_exited(body:Node) -> void:
	if body is RigidBody3D:
		if body.trash == self:
			body.trash = null
	pass