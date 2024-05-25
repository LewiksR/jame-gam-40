extends Node

var active_words = PackedStringArray()

func _init():
	Events.connect(Events.on_key_pressed, _on_key_pressed)	
	Events.connect(Events.on_completed_word, _on_completed_word)

func get_word(length: int) -> String:
	var new_word = "fakeword"
	
	active_words.append(new_word)
	return "fakeword"

func _on_completed_word(word: String):
	var index_of = active_words.find(word)
	active_words.remove_at(index_of)

func _on_key_pressed(key: String):
	print("Received signal: " + key)
