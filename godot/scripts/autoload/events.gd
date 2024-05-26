extends Node

var on_key_pressed := "key_pressed"
signal key_pressed(key: String)

var on_completed_word := "completed_word"
signal completed_word(word: String)

var on_sold_cookie := "sold_cookie"
signal sold_cookie(score: int)

var on_destroyed_yarn := "destroyed_yarn"
signal destroyed_yarn(score: int)

var on_game_started := "game_started"
signal game_started

var on_game_over := "game_over"
signal game_over

var on_score_changed := "score_changed"
signal score_changed(new_score: int)