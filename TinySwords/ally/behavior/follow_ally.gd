extends Node

@export var speed: float = 1.5
var sprite: AnimatedSprite2D
var ally: CharacterBody2D
var base_radius = 400.0
var angle = 0.0
var angular_speed = PI / 4
var current_flip_h = false 

func _ready():
	ally = get_parent()
	sprite = ally.get_node("AnimatedSprite2D")

func _physics_process(delta: float):
	var player_position = GameManager.player_position
	angle += angular_speed * delta
	angle += randf_range(-0.1, 0.1)
	var radius = base_radius + randf_range(-20.0, 20.0)
	var desired_position = player_position + Vector2(cos(angle), sin(angle)) * radius
	var difference = desired_position - ally.position
	if difference.length_squared() < 0.001:
		return
	var input_vector = difference.normalized()
	
	var desired_velocity = input_vector * speed
	ally.velocity = input_vector * speed * 100.0
	
	ally.move_and_slide()

	if input_vector.x > 0 and current_flip_h:
		sprite.flip_h = false
		current_flip_h = false
	elif input_vector.x < 0 and not current_flip_h:
		sprite.flip_h = true
		current_flip_h = true

