class_name  HitArea2D
extends Area2D

signal hit_landed(damage: int)

@export var damage = 1
@export_enum("Taurus", "Player") var team = 0


func _on_area_entered(area: Area2D) -> void:
	hit(area)

func hit(hurt_area) -> void:
	if not hurt_area.team == team:
		hit_landed.emit(max(0, damage - hurt_area.defense))
		hurt_area.get_hurt(self)
