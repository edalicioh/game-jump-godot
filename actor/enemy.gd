extends "res://platform/platform.gd"

var directio = Vector2.RIGHT
var velocity = Vector2.ZERO

@export var speed = 100

@onready var screen_size = get_viewport_rect().size

func _physics_process(delta):
	movement(delta)

func movement(delta):
	position += (directio * speed) * delta
	
	if position.x >= screen_size.x:
		$animated.flip_h = !$animated.flip_h
		directio *= -1
		
	if position.x <= 0:
		$animated.flip_h = !$animated.flip_h		
		directio *= -1
	
func response():
	emit_signal("delete_objct", self)



func _on_hitbox_body_entered(body):
	if body.is_in_group("player") and body.has_method('die'):
		body.die()
