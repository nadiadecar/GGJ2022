extends Node2D


onready var player = $"Characters/Prota"
onready var constant = $"Constant"
onready var GameOverText = $"Constant/Game Over"
onready var fondo = $Fondo

onready var timer = $EnemiesCreator

var random = RandomNumberGenerator.new()
var trident_enemy = preload("res://Scenes/Personajes/Enemy-Trident.tscn")
var gun_enemy = preload("res://Scenes/Personajes/Enemy-Gun.tscn")
var pos_player = Vector2.ZERO

func _ready():
	enemeiesCreate()

func enemeiesCreate(): 
	
	if pos_player.x > 1060 and not player.dead: 
		var pos_x = random.randi_range(860,15400)
		var type = random.randi_range(0,1)
		var enemy
		if type == 1: 
			enemy = trident_enemy.instance()
		else: 
			enemy = gun_enemy.instance()
			#enemy = trident_enemy.instance()
		add_child(enemy)
		enemy.position = Vector2(pos_x, -125)
		
	timer.set_wait_time(1.2)
	timer.start()


func _physics_process(delta):
	pos_player = player.position
	
	constant.position = Vector2(pos_player.x , pos_player.y - 276)
	fondo.position = constant.position
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


func _on_EnemiesCreator_timeout():
	enemeiesCreate()
