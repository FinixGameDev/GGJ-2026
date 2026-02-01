extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is PassThroughPlayer2D:
		get_tree().change_scene_to_file("res://you_win.tscn")
