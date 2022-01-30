extends "res://Scripts/Enemy-General.gd"

onready var BULLETE_SCENE = preload("res://Scenes/Bullete.tscn")

func _ready():
	self.set_damage(150)
	$AnimationTree.active = true
	get_node("AnimationPlayer")

func fire(): 
	var bullet = BULLETE_SCENE.instance()
	bullet.position = get_global_position()
	bullet.player = player
	get_parent().add_child(bullet)
	timer.set_wait_time(1.75)
	timer.start()

		

func _on_Timer_timeout():
	timer.stop()
	if player:
		fire()


func _on_attackedTimer_timeout():
	attacked_timer.stop()
	set_attacked(false)
	if HP <= 0: 
		dead = true 
		get_parent().remove_child(self)
