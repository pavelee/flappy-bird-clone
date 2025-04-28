extends CanvasLayer

class_name UI

@onready var score_label: Label = %ScoreLabel
@onready var start_menu: Control = %StartMenu
@onready var game_over_container: VBoxContainer = %GameOver
@onready var current_score: Label = %CurrentScore
@onready var highscore: Label = %Highscore

func _ready() -> void:
	score_label.text = "0"
	
func update_score(points: int) -> void:
	score_label.text = str(points)
	current_score.text = str(points)
	highscore.text = str(10)
	
func game_over() -> void:
	game_over_container.show()
	score_label.hide()


func _on_ok_button_pressed() -> void:
	get_tree().reload_current_scene()
