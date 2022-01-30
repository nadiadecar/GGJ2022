extends KinematicBody2D

var HP = 700 
var GRAVITY = 400
var lineal_vel = Vector2.ZERO
var prota
var player
var move = Vector2.ZERO
var SPEED = 200
var DAMAGE 
var dead = false 
var attacked = false 
var to_right = true
signal game_over


onready var timer = $Timer
onready var attacked_timer = $attackedTimer 
onready var playback = $AnimationTree.get("parameters/playback")

func set_attacked(val): 
	attacked = val

func set_damage(dam): 
	DAMAGE = dam

func _physics_process(delta) -> void:
	# MOVIMIENTO
	lineal_vel = move_and_slide(lineal_vel, Vector2.UP)
	lineal_vel.y += GRAVITY * delta
	
	
	if player: 
		move = position.direction_to(player.position) * SPEED
		if move.x < 0: 
			to_right = false
		else: to_right = true
	else: 
		move = Vector2.ZERO
	
	if attacked: 
		print("atacado")
		if to_right: 
			playback.travel("Damage-Right")
		else: 
			playback.travel("Damage-Left")
			
		attacked_timer.set_wait_time(0.5)
		attacked_timer.start()
	else: 
		if to_right: 
			playback.travel("Base-Right")
		else: 
			playback.travel("Base-Left")
	
	move = move.normalized()
	move_and_collide(move)
	


func recive_damage(damage): 
	HP -= damage 
	set_attacked(true)
	print("Enemy life:" , HP)
	if HP <= 0: 
		dead = true 
		get_parent().remove_child(self)
	

func _on_Area2D_body_entered(body):
	if body != self and body.is_in_group("prota"):
		player = body 

func _on_Area2D_body_exited(body):
	if body.is_in_group("prota"):
		player = null




