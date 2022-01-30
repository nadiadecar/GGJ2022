extends KinematicBody2D


var HP = 1000
var GRAVITY = 1200
var lineal_vel = Vector2.ZERO
var SPEED = 400
var ACCELERATION = 1

var to_right = true
var can_jump = true
var can_attack = true
var is_wolf = true
var upcoming_change = false 
var walking = false
var waiting = false
var jumped = false
var attacked = false 
var got_attacked = false
var dead = false 

var on_floor
var collider 

signal game_over

onready var timer = $Timer
onready var attacked_timer = $attackedTimer
onready var playback = $AnimationTree.get("parameters/playback")
onready var world = get_parent().get_parent()
onready var playbackBarra = world.get_node("Constant/AnimationTree").get("parameters/playback")

func _ready() -> void:
	$AnimationTree.active = true
	world.get_node("Constant/AnimationTree").active = true
	world.get_node("Constant/AnimationPlayer")
	get_node("AnimationPlayer")
	



func get_movement():
	if Input.is_action_pressed("jump") and can_jump and not jumped:
		$"Sfx/sonido_salto_lobo".play()
		can_jump = false 
		lineal_vel.y = -SPEED*0.9
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
	
	collider = false
	
	var collision = false
	
	if to_right: 
		if $"attack-right/ray-right".is_colliding():
			collider = $"attack-right/ray-right".get_collider()
			collision = true
	else: 
		if $"attack-left/ray-left".is_colliding():
			collider = $"attack-left/ray-left".get_collider()
			collision = true 
	
	if collision:
		if collider.is_in_group("enemy"): 
			collider.recive_damage(400)
		
	$"Sfx/sonido_golpe".play()
	if to_right:
		playback.travel("Attack-Right")
	else: 
		playback.travel("Attack-Left")


func recive_damage(damage): 
	$"Sfx/sonido_recibir_danio".play()
	HP -= damage 
	playbackBarra.travel(String(HP/100))
	got_attacked = true
	attacked_timer.set_wait_time(1)
	attacked_timer.start()
	print(HP)
	if HP <= 0: 
		emit_signal("game_over")



func _physics_process(delta) -> void:
	# MOVIMIENTO
	lineal_vel = move_and_slide(lineal_vel, Vector2.UP)
	lineal_vel.y += GRAVITY * delta
	
	on_floor = is_on_floor()
	
	if not dead: 
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
				

			
		if got_attacked: 
			if to_right: 
				playback.travel("Damage-Right")
			else:
				playback.travel("Damage-Left")
			
		walking = false 
		
		if lineal_vel.y == 0: 
			jumped = false
		
		if Input.is_action_just_released("attack") and not waiting:
			waiting = true 
			timer.set_wait_time(1)
			timer.start()
	
	if dead: 
		if to_right: 
			playback.travel("Dead-Right")
		else:
			playback.travel("Dead-Left")
	

func _on_Timer_timeout():
	timer.stop()
	can_attack = true
	waiting = false
	attacked = false 


func _on_attackedTimer_timeout():
	attacked_timer.stop()
	got_attacked = false
