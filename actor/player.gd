extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -600.0


@onready var anim := $animated as AnimatedSprite2D
@onready var screen_size = get_viewport_rect().size
@onready var jump_fx = $jump_fx

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jump = false

func move(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	var collision = move_and_collide(velocity * delta)

	if velocity.y > 0:
		anim.play("fall")
	else: 
		anim.play("idle")
	
	if collision:
		velocity.y = JUMP_VELOCITY * collision.get_collider().jump_force
		jump_fx.play()
		
		is_jump = false
		if collision.get_collider().has_method('response'):
			collision.get_collider().call('response')
		
	if Input.is_action_just_pressed("ui_accept" ) and !is_jump:
		velocity.y = JUMP_VELOCITY 
		jump_fx.play()
		is_jump = true
		
		
	
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = lerp(velocity.x, direction * SPEED ,0.5)
		anim.scale.x = -direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func _physics_process(delta):
	move(delta)	
	position.x = wrapf(position.x,0 , screen_size.x)
	
func die():
	velocity = Vector2.ZERO
	set_collision_mask_value(1, false)
	if get_tree().change_scene_to_file("res://scenes/menu_screen.tscn") != OK:
		print("erro de jump")
	
