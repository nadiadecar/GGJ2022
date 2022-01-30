extends KinematicBody2D


var HP = 1000
var GRAVITY = 600
var lineal_vel = Vector2.ZERO
var SPEED = 300
var ACCELERATION = 1
var to_right = true
var can_jump = true
var can_attack = true
var is_wolf = true
var upcoming_change = false 
var on_floor
var collider 
var walking = false
var waiting = false
var jumped = false
var attacked = false 
signal game_over

onready var timer = $Timer
onready var playback = $AnimationTree.get("parameters/playback")

func _ready() -> void:
	$AnimationTree.active = true
	get_node("AnimationPlayer")



func get_movement():
	if Input.is_action_pressed("jump") and can_jump and not jumped:
		$"Sfx/sonido_salto_lobo".play() 
		can_jump = false 
		lineal_vel.y = -SPEED
		jumped = true

	if Input.is_action_just_released("jump") and not can_jump:
		can_jump = true 

	if Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		to_right = true
		lineal_vel.x += SPEED
		walking = true

	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		to_right = false
		lineal_vel.x -= SPEED
		walking = true



func wolf_attack():
	$"Sfx/sonido_golpe".play()
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
			collider.recive_damage(400)


func recive_damage(damage): 
	$"Sfx/sonido_recibir_danio".play()
	HP -= damage 
	print(HP)
	if HP <= 0: 
		emit_signal("game_over")



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
			attacked = true
			can_attack = false 
			lineal_vel.x = 0
			wolf_attack()
			
			

	#Animations 
	if on_floor and not attacked: 
		if abs(lineal_vel.x) <= 0 and not jumped:
			if to_right:
				playback.travel("Idle-Right")
			else:
				playback.travel("Idle-Left")
		if walking and can_jump: 
			if to_right: 
				playback.travel("Walking-Right")
			else: 
				playback.travel("Walking-Left")
	if jumped: 
		if to_right: 
			playback.travel("Jumping-Right")
		else: 
			playback.travel("Jumping-Left")
			
	if attacked: 
		if to_right:
			playback.travel("Attack-Right")
		else: 
			playback.travel("Attack-Left")
		
	
	walking = false 
	
	if lineal_vel.y == 0: 
		jumped = false
	
	if Input.is_action_just_released("attack") and not waiting:
		waiting = true 
		timer.set_wait_time(1)
		timer.start()
	

func _on_Timer_timeout():
	timer.stop()
	can_attack = true
	waiting = false
	attacked = false 
