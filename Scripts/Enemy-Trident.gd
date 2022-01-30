extends "res://Scripts/Enemy-General.gd"

func _ready():
	self.set_damage(200)
	$AnimationTree.active = true
	get_node("AnimationPlayer")


func _on_tridentright_body_entered(body):
	if body.is_in_group("prota"): 
		prota = body 
		damage_prota()

func _on_tridentleft_body_entered(body):
	if body.is_in_group("prota"): 
		prota = body
		damage_prota()


func damage_prota(): 
	if prota.HP > 0: 
		prota.recive_damage(DAMAGE)
		timer.set_wait_time(1.5)
		timer.start()
	else: 
		emit_signal("game_over")
		

func _on_Timer_timeout():
	timer.stop()
	damage_prota()


func _on_attackedTimer_timeout():
	attacked_timer.stop()
	self.set_attacked(false) 
