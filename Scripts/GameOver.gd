extends Node2D

onready var timer = $Timer
onready var whiteWords = $Blanco

var white = false 


func _ready():
	colors()

func colors():
	if not white: 
		white = true 
		whiteWords.show()
	else: 
		white = false 
		whiteWords.hide()

	timer.set_wait_time(0.4)
	timer.start()

func _on_Timer_timeout():
	timer.stop()
	colors()
