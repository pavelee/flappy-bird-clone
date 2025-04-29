extends Node2D

var SAVE_FILE: String = "user://score.save"

@onready var spawner: Spawner = $Spawner
@onready var player: Player = $Player
@onready var ground: Ground = $Ground
@onready var ui: UI = $UI
@onready var game_over_audio: AudioStreamPlayer2D = $GameOverAudio

var score := 0
var high_score := 0

func _ready() -> void:
	high_score = load_highscore()

func _on_player_on_game_started() -> void:
	# we start spawning obstacle
	spawner.timer.start()
	ui.start_menu.hide()

func _on_spawner_on_obstacle_crash() -> void:
	end_game()

func _on_ground_on_player_crash() -> void:
	end_game()
	
func end_game() -> void:
	spawner.stop_obstacles()
	player.stop_gravity()
	player.stop_movement()
	ground.stop_movement()
	if (score > high_score):
		high_score = score
		save_highscore(high_score)
	ui.calculate_score(score, high_score)
	ui.game_over()
	game_over_audio.play()

func load_highscore() -> int:
	var hs = 0
	var file: FileAccess = FileAccess.open(SAVE_FILE, FileAccess.READ)
	if file:
		hs = file.get_32()
	return hs
		
func save_highscore(score: int) -> void:
	var file: FileAccess = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	file.store_32(score)

func _on_spawner_on_player_score() -> void:
	score += 1
	ui.update_score(score)
