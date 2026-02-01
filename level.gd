extends Node2D

@export var zones : Array[PackedScene]
@export var final_zone : PackedScene
@export var initial_zone : PackedScene

@export var zones_count = 26
@export var zone_length = 640
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	
	add_child(initial_zone.instantiate())
	
	var previous_rand : int
	
	for i in range(1,  zones_count - 1):
		var rand = randi() % zones.size()
		
		if i == 1:
			rand = 0
		elif rand == previous_rand:
			rand += randi() % zones.size()
			rand = rand % zones.size()
		
		var node = zones[rand].instantiate()
		add_child(node)
		node.position.x = i * zone_length
		previous_rand = rand
		
	var finish = final_zone.instantiate() as Node2D
	
	add_child(finish)
	finish.position.x = (zones_count - 1) * zone_length
