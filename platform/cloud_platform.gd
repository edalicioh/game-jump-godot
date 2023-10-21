extends "res://platform/platform.gd"

func response():
	emit_signal("delete_objct", self)
