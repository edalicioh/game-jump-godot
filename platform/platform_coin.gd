extends "res://platform/platform.gd"

@onready var coin  = $coin

func _ready():
	coin.connect("collect_objct", delete_collect_objct)

func delete_collect_objct(_coin):
	_coin.queue_free()
