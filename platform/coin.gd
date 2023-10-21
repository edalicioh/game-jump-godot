extends Node2D

@export var collect = 1.0
signal collect_objct(obstacle) 

func _on_area_2d_body_entered(_body):
	Global.update_collect(collect)
	emit_signal("collect_objct" ,self)
