extends Node2D

signal action_complete

@export var HIGHLIGHT_COLOR: Color = Color.GOLD
@export var LABEL_TEMPLATE = "[outline_size=7][outline_color=#000000][center][color=\"#%s\"]%s[/color]%s[/center]"
var _my_word: String
var _typed_string: String
@onready var label = %WordLabel


func _ready():
	Events.connect(Events.on_completed_word, _on_completed_word)
	Events.connect(Events.on_key_pressed, _on_key_pressed)
	
	var word_length: int = randi_range(4, 6)
	_my_word = WordsManager.get_word(word_length)
	_update_label()


func _handle_word_update(new_char: String):
	if new_char == _get_next_character():
		# Next character matches this word's next character
		_typed_string += new_char
		if !_get_next_character():
			Events.completed_word.emit(_my_word)
			action_complete.emit()
	else:
		_reset_progress()
	_update_label()


func _reset_progress():
	_typed_string = ""
	_update_label()


func _update_label():
	label.text = _get_formatted_label_text(_typed_string, _get_remaining_word())


func _get_formatted_label_text(typed_string: String, remaining_word: String) -> String:
	var color_string = HIGHLIGHT_COLOR.to_html(false)
	var formatted_string = LABEL_TEMPLATE % [color_string, typed_string, remaining_word]
	
	return formatted_string


func _get_remaining_word() -> String:
	var characters_typed: int = _typed_string.length()
	var remaining_word = _my_word.substr(characters_typed)
	return remaining_word


func _get_next_character() -> String:
	var remaining_word = _get_remaining_word()
	return remaining_word[0] if remaining_word else ""


func _on_completed_word(word: String):
	if word != _my_word:
		_reset_progress()


func _on_key_pressed(key: String):
	_handle_word_update(key.to_lower())
