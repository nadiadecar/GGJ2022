extends KinematicBody2D

var move = Vector2.ZERO
var SPEED = 30
var player = null
var lineal_vel = Vector2.ZERO

onready var bull = $bullete
onready var ray = $"CollisionShape2D/RayBullete"

	
func _physics_process(delta):
	lineal_vel = move_and_slide(lineal_vel, Vector2.UP)
	move = position.direction_to(player.position) * SPEED
	move = move.normalized() 
	move_and_collide(move)
	
	if ray.is_colliding(): 
		var collider = ray.get_collider()
		if collider.is_in_group("prota"):
			player.recive_damage(100)
			get_parent().remove_child(self)

	
	
	
