extends "res://platform/platform.gd"

func response():
	$animated.play("default")

func _on_animated_animation_finished():
	$animated.frame = 0
	$animated.stop()
	
