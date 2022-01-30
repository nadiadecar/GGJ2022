extends Node2D


onready var player = $"Characters/Prota"
onready var constant = $"Constant"
onready var GameOverText = $"Constant/Game Over"

func _physics_process(delta):
	var pos_player = player.position
	
	constant.position = Vector2(pos_player.x , pos_player.y - 276)
	
	
func _on_Prota_game_over():
	GameOverText.show()
	player.dead = true 
	if player.to_right: 
		player.playback.travel("Dead-Right")
	else:
		player.playback.travel("Dead-Left")
