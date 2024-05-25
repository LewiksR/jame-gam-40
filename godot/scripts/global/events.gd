extends Node

var on_key_pressed: String = "key_pressed"
signal key_pressed(key: String)

var on_completed_word: String = "completed_word"
signal completed_word(word: String)

var on_sold_cookie: String = "sold_cookie"
signal sold_cookie(score: int)

var on_destroyed_yarn: String = "destroyed_yarn"
signal destroyed_yarn(score: int)

var on_game_started: String = "game_started"
signal game_started

var on_game_over: String = "game_over"
signal game_over
