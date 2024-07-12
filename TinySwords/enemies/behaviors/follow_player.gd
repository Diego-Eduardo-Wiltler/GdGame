extends Node

@export var speed: float = 1
var sprite: AnimatedSprite2D

var enemy: CharacterBody2D

func _ready():
	enemy = get_parent()
	sprite = enemy.get_node("AnimatedSprite2D")

func _physics_process(delta: float):
	var player_position = GameManager.player_position
	var difference = player_position - enemy.position  
	if difference.length_squared() < 0.001:
		return
	var input_vector = difference.normalized()
	
	var desired_velocity = input_vector * speed
	enemy.velocity = input_vector * speed * 100.0
	enemy.move_and_slide()

	if input_vector.x > 0:
		sprite.flip_h = false
	elif input_vector.x < 0:
		sprite.flip_h = true
