extends "res://Scripts/Enemy-General.gd"

func _ready():
	set_damage(400)
	$AnimationTree.active = true
	get_node("AnimationPlayer")

