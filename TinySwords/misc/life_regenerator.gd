extends Node

@export var regeneration_amount: int = 2
@export var meat_collect_sound: AudioStreamPlayer2D

func _ready():
	$Area2D.body_entered.connect(on_body_entered)

func on_body_entered(body: Node2D):
	if body.is_in_group("player"):
		var player: Player = body
		player.heal(regeneration_amount)
		player.meat_collected.emit(regeneration_amount)
		meat_collect_sound.play()
		queue_free()
