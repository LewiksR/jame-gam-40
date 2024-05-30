extends Node

@export var COOKIES: Node2D
@export var ENEMY_SCENE: PackedScene
@export var SPAWN_POINTS: Array[Node2D] = []
@export var STARTING_WAVE_INTERVAL: float = 5
@export var FINAL_WAVE_INTERVAL: float = 1
@export var STARTING_ENEMY_SPEED: int = 50
@export var FINAL_ENEMY_SPEED: int = 250
@export var WAVES_TO_MAX_DIFFICULTY: int = 150
@export var TIME_TO_FIRST_WAVE: float = 3
var _next_wave: int = 1
var _max_enemies_in_wave: int = 1
@onready var _wave_timer: Timer = $WaveTimer


# Called when the node enters the scene tree for the first time.
func _ready():
	_max_enemies_in_wave = max(1, SPAWN_POINTS.size() - 1)
	_wave_timer.start(TIME_TO_FIRST_WAVE)


func _spawn_wave(difficulty: float):
	var amount = _get_wave_size(difficulty)
	var selected_spawn_points = _get_spawn_points(amount)
	var speed = _get_new_enemies_speed(difficulty)
	
	for spawn_point in selected_spawn_points:
		_spawn_enemy_at_position(spawn_point.position, speed)

	_wave_timer.start(_get_next_wave_interval(difficulty))
	_next_wave += 1


func _spawn_enemy_at_position(position: Vector2, speed: int):
	var new_enemy = ENEMY_SCENE.instantiate() as MovingEnemy
	add_child(new_enemy)
	new_enemy.position = position
	new_enemy.SPEED = speed
	new_enemy.TARGET_NODE = COOKIES


func _get_spawn_points(amount: int) -> Array[Node2D]:
	SPAWN_POINTS.shuffle()
	return SPAWN_POINTS.slice(0, amount)


func _get_new_enemies_speed(difficulty: float) -> int:
	return lerp(STARTING_ENEMY_SPEED, FINAL_ENEMY_SPEED, difficulty)


func _get_next_wave_interval(difficulty: float) -> float:
	return lerp(STARTING_WAVE_INTERVAL, FINAL_WAVE_INTERVAL, difficulty)


func _get_wave_size(difficulty: float) -> int:
	var amount_float = lerp(1, _max_enemies_in_wave, difficulty)
	amount_float += randf_range(-0.5, 0.5)
	var amount_int = int(ceil(amount_float))
	amount_int = clamp(amount_int, 1, _max_enemies_in_wave)
	return amount_int


func _get_current_difficulty(wave: int) -> float:
	var progress_percent: float = float(wave) / WAVES_TO_MAX_DIFFICULTY
	clamp(progress_percent, 0, 1)
	return sqrt(progress_percent)


func _on_wave_timer_timeout():
	var difficulty = _get_current_difficulty(_next_wave)
	_spawn_wave(difficulty)
