extends KinematicBody2D

var move = Vector2.ZERO
var SPEED = 6
var player = null
var lineal_vel = Vector2.ZERO
var to_right = true 

onready var bull = $bullete
onready var ray = $"CollisionShape2D/RayBullete"

func _ready():
	
	move = position.direction_to(Vector2(player.position.x, position.y)) * SPEED

	
func _physics_process(delta):
	lineal_vel = move_and_slide(lineal_vel, Vector2.UP)
	move_and_collide(move)
	if ray.is_colliding(): 
		var collider = ray.get_collider()
		if collider.is_in_group("prota"):
			player.recive_damage(100)
			get_parent().remove_child(self)
	
	if abs(position.x - player.position.x) > 700: 
		get_parent().remove_child(self)

	
	
	
