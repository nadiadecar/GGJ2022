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
signal game_over

onready var timer = $Timer

func set_damage(dam): 
	DAMAGE = dam

func _physics_process(delta) -> void:
	# MOVIMIENTO
	lineal_vel = move_and_slide(lineal_vel, Vector2.UP)
	lineal_vel.y += GRAVITY * delta
	
	if player: 
		move = position.direction_to(player.position) * SPEED
	else: 
		move = Vector2.ZERO
	
	move = move.normalized()
	move_and_collide(move)

func recive_damage(damage): 
	HP -= damage 
	print(HP)
	if HP <= 0: 
		dead = true 
		get_parent().remove_child(self)

func _on_Area2D_body_entered(body):
	if body != self and body.is_in_group("prota"):
		player = body 

func _on_Area2D_body_exited(body):
	if body.is_in_group("prota"):
		player = null




