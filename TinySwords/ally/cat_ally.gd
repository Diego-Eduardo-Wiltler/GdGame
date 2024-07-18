class_name Ally
extends Node2D

@export var damage_amount: int = 2
@export var cat_interval: float = 2.0
@onready var cat_hitbox_area: Area2D = $HitboxArea

var cat_cooldown: float = 0.0

func _ready():
	cat_cooldown = cat_interval  
func _process(delta):
	update_cat_damage(delta)

func deal_damage_to_enemies_with_cat():
	var bodies = cat_hitbox_area.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies"):
			var enemy: Enemy = body
			enemy.damage(damage_amount)
			

func update_cat_damage(delta: float):
	cat_cooldown -= delta
	if cat_cooldown <= 0:  # Se o cooldown acabar
		deal_damage_to_enemies_with_cat()
		cat_cooldown = cat_interval  # Reseta o cooldown
