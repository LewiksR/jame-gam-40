extends CharacterBody2D


@export var SPEED: float = 300.0

func _physics_process(_delta):
	velocity.x = SPEED
	move_and_slide()
