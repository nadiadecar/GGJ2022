extends Button

export var direction = 1
var velocity = 40
var umbral = 4
var max_y = rect_position.y+umbral
var min_y = rect_position.y-(umbral*2)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rect_position.y = rect_position.y + (delta*direction*velocity)
	if rect_position.y>max_y:
		direction = -1
	if rect_position.y<min_y:
		direction = 1

func _on_StartButton_button_down():
		get_tree().change_scene("res://Scenes/Principal.tscn")
