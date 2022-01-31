extends "res://Scripts/Enemy-General.gd"

onready var BULLETE_SCENE_RIGHT = preload("res://Scenes/BulleteRight.tscn")
onready var BULLETE_SCENE_LEFT = preload("res://Scenes/BulleteLeft.tscn")

var arma = Vector2(150,0)

func _ready():
	self.set_damage(150)
	$AnimationTree.active = true
	get_node("AnimationPlayer")
	fire()

func fire():
	if player:  
		var bullet
		var positionBull
		if to_right:
			bullet = BULLETE_SCENE_RIGHT.instance()
			positionBull = get_global_position() + arma
		else:
			bullet = BULLETE_SCENE_LEFT.instance()
			positionBull = get_global_position() - arma
			bullet.to_right = false
			
		bullet.player = player
		bullet.position = positionBull
		get_parent().add_child(bullet)

	timer.set_wait_time(2)
	timer.start()



func _on_Timer_timeout():
	if player != null:
		timer.stop()
		fire()


func _on_attackedTimer_timeout():
	attacked_timer.stop()
	set_attacked(false)
	if HP <= 0: 
		dead = true 
		get_parent().remove_child(self)
