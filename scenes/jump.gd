extends Node2D

@onready var platform_containe = $platform_containe
@onready var platform_initial_position_y  = $platform_containe/platform.position.y

@onready var camera = $camera as Camera2D
@onready var player = $player as CharacterBody2D

@export var platform_scene:  Array[PackedScene]
@onready var score_label = $camera/CanvasLayer/score as Label
@onready var coin_label = $camera/CanvasLayer/coin as Label

@onready var camera_start_position = $camera.position.y

var last_is_platform = false;
var score = 0
var coin = 0


func level_generator():	
	var new_type = randi() % platform_scene.size()
	platform_initial_position_y -= randf_range(50, 150)	
	
	var new_platform = platform_scene[new_type].instantiate() as StaticBody2D
			
	if (new_platform.name == 'platform'):
		new_platform = generator_platform(new_platform)
	
	if new_platform.name == 'spring_platform' :
		new_platform = generator_spring_platform(new_platform)	
		
	if new_platform.name == 'cloud_platform':
		new_platform = generator_cloud_platform(new_platform)
	
	if new_platform.name == 'enemy' :
		new_platform = generator_enemy(new_platform)
	if new_platform.name == 'coin':
		new_platform = generator_coin(new_platform)
	
	new_platform.position = Vector2(randi_range(23, 299) , platform_initial_position_y)
	platform_containe.call_deferred("add_child",new_platform)

func generator_cloud_platform(new_platform):
	if !last_is_platform:
		return generator_platform(platform_scene[0].instantiate())
	if score > 1000:
		new_platform.connect('delete_objct',delete_objct)
		last_is_platform = false
		return new_platform
		
	return generator_platform(platform_scene[0].instantiate())

func generator_spring_platform(new_platform):
	if !last_is_platform: 
		return generator_platform(platform_scene[0].instantiate())
		
	last_is_platform = false
	return new_platform

func generator_platform(new_platform):
	var platform_scale_x = randf_range(0.5, 2)
	last_is_platform = true
	new_platform.scale.x = platform_scale_x
	new_platform.scale.y = 1.5
	return new_platform

func generator_enemy(new_platform):
	
	if !last_is_platform:
		return generator_platform(platform_scene[0].instantiate())
	
	if score >= 1500:
		new_platform.connect('delete_objct',delete_objct)
		last_is_platform = false
		return new_platform
	
	return generator_platform(platform_scene[0].instantiate())

func generator_move_platform(new_platform):
	if score > 500:
		new_platform.connect('delete_objct',delete_objct)
		last_is_platform = true
		return new_platform
	return generator_platform(platform_scene[0].instantiate())

func generator_coin(new_platform):
	new_platform.connect('delete_objct',delete_objct)
	return new_platform

func delete_objct(obstacle):
	if obstacle.is_in_group("player"):
		Global.update_score(score)
		if get_tree().change_scene_to_file("res://scenes/menu_screen.tscn") != OK:
			print("erro de jump")
		
	if obstacle.is_in_group("plarform") or obstacle.is_in_group("enemies")  :
		obstacle.queue_free()
		level_generator()
		level_generator()


func _ready() -> void:
	randomize()
	for items in 20 :
		level_generator()

func _physics_process(_delta):
	score_update()
	coin_label.text = str(Global.collect)
	if camera.position.y > player.position.y:
		camera.position.y = player.position.y


func _on_clean_platform_body_entered(body):
	delete_objct(body)

func score_update():
	score = camera_start_position - camera.position.y
	score_label.text = str(int(score))
	Global.update_score(score)
	


func _on_touch_screen_button_pressed():
	Global.update_score(score)
	if get_tree().change_scene_to_file("res://scenes/menu_screen.tscn") != OK:
		print("erro de jump")
