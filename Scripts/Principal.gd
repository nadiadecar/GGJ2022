extends Node2D


var prota
var characters

func _ready():
	prota = $Characters/Prota
	characters = $Characters
	characters.connect("enemy_died", self, "remove_enemy")


func _physics_process(delta) -> void:
	pass

func remove_enemy():
	var dead_enemy = prota.collider
	print('llega la señal') 


func _on_Prota_enemy_died():
	pass # Replace with function body.
