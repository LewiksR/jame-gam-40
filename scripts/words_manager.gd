extends Node



# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


func get_word(length: int) -> String:
	
	
	return "fakeword"

func _on_key_pressed(key: String):
	print("Received signal: " + key)
