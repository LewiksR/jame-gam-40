extends Object

signal score_changed(new_score: int)

var individual_scores = {
    "cookies-sold": 0,
    "yarn-destroyed": 0,
}


func _init():
    Events.connect(Events.on_sold_cookie, _on_sold_cookie)
    Events.connect(Events.on_destroyed_yarn, _on_destroyed_yarn)
    Events.connect(Events.on_game_started, _on_game_started)


func _get_total_score() -> int:
    var total: int = 0
    for score in individual_scores:
        total += score
    return total


func _increment_score(name: String, score: int):
    individual_scores[name] += score
    score_changed.emit(_get_total_score)


func _on_sold_cookie(score: int):
    _increment_score("cookies-sold", score)


func _on_destroyed_yarn(score: int):
    _increment_score("yarn-destroyed", score)


func _on_game_started():
    for key in individual_scores.keys():
        individual_scores[key] = 0