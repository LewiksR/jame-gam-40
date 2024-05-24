extends Node

signal key_pressed(key: String)

var _regex = RegEx.new()

func _init():
	# match only events ending in a single capital letter from A to Z
	_regex.compile("[A-Z]{1}$")

func _input(event):
	if !(event is InputEventKey and event.is_pressed()):
		return
	
	var regex_result = _regex.search(event.as_text())
	if !regex_result:
		return
	
	var found_key = regex_result.get_string()
	key_pressed.emit(found_key)
