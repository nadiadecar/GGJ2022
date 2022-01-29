extends KinematicBody2D

var life = 700 
var GRAVITY = 400
var lineal_vel = Vector2.ZERO
var prota
var move = Vector2.ZERO
var SPEED = 200

func _physics_process(delta) -> void:
	# MOVIMIENTO
	lineal_vel = move_and_slide(lineal_vel, Vector2.UP)
	lineal_vel.y += GRAVITY * delta
	
	if prota: 
		move = position.direction_to(prota.position) * SPEED
	else: 
		move = Vector2.ZERO
	
	move = move.normalized()
	move_and_collide(move)


func _on_Area2D_body_entered(body):
	if body != self and body.is_in_group("prota"):
		prota = body 

func _on_Area2D_body_exited(body):
	if body.is_in_group("prota"):
		prota = null
