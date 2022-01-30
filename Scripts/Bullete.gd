extends Area2D

var move = Vector2.ZERO
var look_vec = Vector2.ZERO
var SPEED = 350
var player

func _ready():
	look_vec = player.position - global_position
	
func _physics_process(delta):
	move = Vector2.ZERO
	move = move.move_toward(look_vec, delta)
	move = move.normalized() * SPEED
	position += move
