extends Node

const FILE_PATH: String = "res://data/words.json"

var _word_list: Dictionary = {}
var _active_words = PackedStringArray()


func get_word(length: int) -> String:
	var possible_words: Array = _word_list[str(length)]
	var new_word: String
	while (true):
		var index:= randi_range(0, possible_words.size())
		new_word = possible_words[index]
		if new_word not in _active_words:
			break

	_active_words.append(new_word)
	return new_word


func _init():
	_load_word_list()
	Events.connect(Events.on_completed_word, _on_completed_word)


func _load_word_list():
	var file = FileAccess.open(FILE_PATH, FileAccess.READ)
	var json_str = file.get_as_text()
	_word_list = JSON.parse_string(json_str)


func _on_completed_word(word: String):
	var index_of = _active_words.find(word)
	_active_words.remove_at(index_of)
