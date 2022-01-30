extends Node2D


onready var player = $"Characters/Prota"
onready var constant = $"Constant"
onready var GameOverText = $"Constant/Game Over"

var trident_enemy = preload("res://Scenes/Personajes/Enemy-Trident.tscn")
var gun_enemy = preload("res://Scenes/Personajes/Enemy-Gun.tscn")


func _physics_process(delta):
	var pos_player = player.position
	
	constant.position = Vector2(pos_player.x , pos_player.y - 276)
	if Input.is_action_pressed("restart") and player.dead: 
		print("lo pesca")
		get_tree().change_scene("res://Scenes/Principal.tscn")
	
func _on_Prota_game_over():
	GameOverText.show()
	player.dead = true 
	if player.to_right: 
		player.playback.travel("Dead-Right")
	else:
		player.playback.travel("Dead-Left")
