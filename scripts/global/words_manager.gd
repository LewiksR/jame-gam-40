extends Node

#temp
var _next_word_index = 0
var word_list = ["worda", "ward", "werd", "weird", "worde", "wordf"]

var _active_words = PackedStringArray()


func _init():
	Events.connect(Events.on_completed_word, _on_completed_word)


func get_word(_length: int) -> String:
	var new_word = word_list[_next_word_index]
	_next_word_index += 1

	_active_words.append(new_word)
	return new_word


func _on_completed_word(word: String):
	var index_of = _active_words.find(word)
	_active_words.remove_at(index_of)
