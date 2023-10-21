extends Node

var highscore = 0
var collect = 0

var save_path = 'user://save.dat'

func update_score(score):
	if score > highscore:
		presist_data()
		highscore = score

func update_collect(valeu):
	collect += valeu

func presist_data():
	var file = FileAccess.open(save_path,FileAccess.WRITE)
	file.store_var(highscore)
	file= null
	
func load_data():
	var file = FileAccess.open(save_path,FileAccess.READ)
	var data = file.get_var()
	highscore = data

func _ready():
	load_data()
