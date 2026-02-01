extends BasicMovingCharacter2D
class_name PassThroughCharacter2D

@export_flags_2d_physics var pass_through_layer = 2

func enable_pass_through():
	var layer_number = (log(pass_through_layer) / log(2)) + 1
	set_collision_mask_value(layer_number,false)

func disable_pass_through():
	var layer_number = (log(pass_through_layer) / log(2)) + 1
	set_collision_mask_value(layer_number, true)
