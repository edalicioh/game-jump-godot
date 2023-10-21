extends Control

@onready var highscore = $main/score as Label

func _ready():
	Global.load_data()
	highscore.text = str( int(Global.highscore))

func _on_btnstart_pressed():
	if get_tree().change_scene_to_file("res://scenes/jump.tscn") != OK:
		print("erro de jump")


func _on_btnquit_pressed():
	get_tree().quit()
