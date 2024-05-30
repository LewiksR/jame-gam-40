class_name MovingEnemy extends CharacterBody2D

@export var POINTS_WORTH: int = 5
@export var SPEED: float = 300.0
@export var TARGET_NODE: Node2D
var _is_alive: bool = true


func _physics_process(delta):
	var vector_to_target = TARGET_NODE.position - position
	var angle_to_target = vector_to_target.angle()
	velocity = Vector2(SPEED, 0).rotated(angle_to_target)
	var collision := move_and_collide(velocity * delta)
	if collision:
		Events.game_over.emit()


func _on_action_complete():
	_is_alive = false
	$AnimationPlayer.play("yarn_death")
	Events.destroyed_yarn.emit(POINTS_WORTH)


func _on_animation_finished(anim_name):
	if anim_name == "yarn_death":
		queue_free()
