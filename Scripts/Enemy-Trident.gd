extends "res://Scripts/Enemy-General.gd"

func _ready():
	self.set_damage(100)
	$AnimationTree.active = true
	get_node("AnimationPlayer")


func _on_tridentright_body_entered(body):
	if body.is_in_group("prota") and not (dead or attacked): 
		prota = body 
		damage_prota()

func _on_tridentleft_body_entered(body):
	if body.is_in_group("prota") and not (dead or attacked) : 
		prota = body
		damage_prota()


func damage_prota(): 
	if prota.HP > 0 and abs(prota.position.x - position.x) < 125: 
		prota.recive_damage(DAMAGE)
		timer.set_wait_time(1.75)
		timer.start()
	else: 
		emit_signal("game_over")
		

func _on_Timer_timeout():
	timer.stop()
	if not (dead or attacked):
		damage_prota()


func _on_attackedTimer_timeout():
	attacked_timer.stop()
	set_attacked(false)
	if HP <= 0: 
		dead = true 
		get_parent().remove_child(self)
