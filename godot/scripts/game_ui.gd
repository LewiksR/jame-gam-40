extends Control

@export var LABEL_TEMPLATE := "Score: %s"
@onready var _score_label := $ScoreLabel


func _ready():
	Events.connect(Events.on_score_changed, _on_score_changed)
	_set_label_score(0)


func _set_label_score(score: int):
	_score_label.text = LABEL_TEMPLATE % str(score)

func _on_score_changed(new_score: int):
	_set_label_score(new_score)

