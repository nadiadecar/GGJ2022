extends Area2D

var move = Vector2.ZERO
var look_vec = Vector2.ZERO
var SPEED = 50
var player = null
var lineal_vel = Vector2.ZERO

onready var bull = $bullete

func _ready():
	look_vec = player.position - global_position
	
func _physics_process(delta):
	move = Vector2.ZERO
	move = move.move_toward(look_vec, delta)
	move = move.normalized() * SPEED
	
