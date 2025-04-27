extends Node2D

@onready var spawner: Spawner = $Spawner
@onready var player: Player = $Player
@onready var ground: Ground = $Ground

func _on_player_on_game_started() -> void:
	# we start spawning obstacle
	spawner.timer.start()

func _on_spawner_on_obstacle_crash() -> void:
	end_game()


func _on_ground_on_player_crash() -> void:
	end_game()
	
func end_game() -> void:
	spawner.stop_obstacles()
	player.stop_gravity()
	player.stop_movement()
	ground.stop_movement()
