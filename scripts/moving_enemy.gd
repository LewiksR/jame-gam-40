extends CharacterBody2D

@export var POINTS_WORTH: int = 5
@export var SPEED: float = 300.0
var _is_alive: bool = true


func _physics_process(_delta):
	velocity.x = SPEED
	move_and_slide()


func _on_action_complete():
	_is_alive = false
	$AnimationPlayer.play("yarn_death")
	Events.destroyed_yarn.emit(POINTS_WORTH)


func _on_animation_finished(anim_name):
	if anim_name == "yarn_death":
		queue_free()
