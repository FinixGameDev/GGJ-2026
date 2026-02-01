extends PassThroughCharacter2D
class_name PassThroughPlayer2D

@export var move_left_action = "move_left"
@export var move_right_action = "move_right"
@export var move_down_action = "move_down"
@export var jump_action = "jump"

@onready var sprite_idle = $Idle as Sprite2D
@onready var sprite_move = $Move as Sprite2D
@onready var sprite_jump = $Jump as Sprite2D
@onready var sprite_dead = $Dead as Sprite2D

enum SpriteType {IDLE, MOVE, JUMP, DEAD}
var is_inverted = false

func _physics_process(delta: float) -> void: 
	super._physics_process(delta)
	
	if not is_on_floor():
		set_sprite(SpriteType.JUMP,is_inverted)
	elif not direction == 0:
		set_sprite(SpriteType.MOVE, is_inverted)
	else: 
		set_sprite(SpriteType.IDLE, is_inverted)
	
	match direction:
		-1:
			is_inverted = true
		1:
			is_inverted = false
	
	if position.y >= 250:
		_on_hurt(1)

func _unhandled_input(event):
	# Horizontal movement
	if event.is_action(move_left_action):
		if event.is_pressed():
			direction = -1
		elif Input.is_action_pressed(move_right_action):
			direction = 1
		else:
			direction = 0
			set_sprite(SpriteType.IDLE, is_inverted)
	elif event.is_action(move_right_action):
		if event.is_pressed():
			direction = 1
		elif Input.is_action_pressed(move_left_action):
			direction = -1
		else:
			direction = 0
	# Vertical movement
	if event.is_action_pressed(jump_action):
		# Pass through logic
		if Input.is_action_pressed(move_down_action):
			enable_pass_through()
		else:
			jump()
			$JumpSound.play()
	elif event.is_action_released(jump_action):
		cancel_jump()
	
	if event.is_action_released(move_down_action):
		disable_pass_through()
	

func set_sprite(type: SpriteType, inverted = false):
	match type:
		SpriteType.IDLE:
			sprite_idle.visible = true
			sprite_move.visible = false
			sprite_jump.visible = false
		SpriteType.MOVE:
			sprite_idle.visible = false
			sprite_move.visible = true
			sprite_jump.visible = false
		SpriteType.JUMP:
			sprite_idle.visible = false
			sprite_move.visible = false
			sprite_jump.visible = true
		SpriteType.DEAD:
			sprite_dead.visible = true
			sprite_idle.visible = false
			sprite_move.visible = false
			sprite_jump.visible = false
	
	if inverted:
		sprite_idle.flip_h = true
		sprite_move.flip_h = true
		sprite_jump.flip_h = true
	else:
		sprite_idle.flip_h = false
		sprite_move.flip_h = false
		sprite_jump.flip_h = false
	
	is_inverted = inverted


func _on_hurt(damage: Variant) -> void:
	set_sprite(SpriteType.DEAD)
	$Death.play()
	direction = 0
	gravity = 0
	set_process_unhandled_input(false)
	await get_tree().create_timer(1).timeout
	get_tree().reload_current_scene()
