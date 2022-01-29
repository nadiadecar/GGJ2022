extends KinematicBody2D


var life = 1000
var GRAVITY = 400
var lineal_vel = Vector2.ZERO
var SPEED = 200
var ACCELERATION = 1
var to_right = true
var can_jump = true
var can_attack = true
var is_wolf = true
var upcoming_change = false 
var on_floor
var collider 
var kills = 0
signal end_game 

func _ready() -> void:
	pass
#	$AnimationTree.active = true
#	get_node("AnimationPlayer")



func get_movement():
	if on_floor and Input.is_action_pressed("jump") and can_jump:
		can_jump = false 
		lineal_vel.y = -SPEED

	if Input.is_action_just_released("jump") and not can_jump:
		can_jump = true 

	if Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		to_right = true
		lineal_vel.x += 300


	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		to_right = false
		lineal_vel.x -= 300



func wolf_attack():
	collider = false
	var collision = false
	if to_right: 
		if $"attack-right/ray-right".is_colliding():
			collider = $"attack-right/ray-right".get_collider()
			collision = true
	else: 
		if $"attack-right/ray-right".is_colliding():
			collider = $"attack-right/ray-right".get_collider()
			collision = true 

	if collision:
		if collider.is_in_group("enemy"): 
			get_parent().remove_child(collider)
			kills += 1
			if kills == 100: 
				emit_signal("end_game")



func _physics_process(delta) -> void:
	# MOVIMIENTO
	lineal_vel = move_and_slide(lineal_vel, Vector2.UP)
	lineal_vel.y += GRAVITY * delta
	
	on_floor = is_on_floor()
	
	get_movement()
	lineal_vel = move_and_slide(lineal_vel)
	lineal_vel.x = 0
	
	if Input.is_action_pressed("attack") and can_attack:
		if is_wolf:
			can_attack = false
			wolf_attack()
			
	if Input.is_action_just_released("attack"):
		can_attack = true 
