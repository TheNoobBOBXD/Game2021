extends RayCast


var current_collider
onready var interaction_label = get_node("/root/World/UI/InteractionLabel"
)
func _process(delta):
	var collider = get_collider()
	
	if is_colliding() and collider is Interactable:
		if current_collider != collider:
			current_collider = collider 
	elif current_collider:
		current_collider = null
