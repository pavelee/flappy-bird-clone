extends Node2D

@onready var spawner: Spawner = $Spawner
@onready var player: Player = $Player
@onready var ground: Ground = $Ground
@onready var ui: UI = $UI

var score := 0

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
	ui.game_over()


func _on_spawner_on_player_score() -> void:
	score += 1
	ui.update_score(score)
