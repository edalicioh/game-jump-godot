extends "res://platform/platform.gd"

var directio = Vector2.RIGHT
var velocity = Vector2.ZERO

@onready var screen_size = get_viewport_rect().size

@export var speed_max = 100
@export var speed_min = 20

func _ready() -> void:
	randomize()

func _physics_process(delta):
	movement(delta)

func movement(delta):
	position += (directio * randf_range(speed_min, speed_max)) * delta
		
	if position.x >= screen_size.x:
		directio *= -1
		
	if position.x <= 0:		
		directio *= -1
