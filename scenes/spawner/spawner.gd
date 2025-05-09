extends Node2D

class_name Spawner

signal on_obstacle_crash
signal on_player_score

const OBSTACLE = preload("res://scenes/obstacle/obstacle.tscn")
@onready var timer: Timer = $Timer

func create_obstacle() -> void:
	var obs = OBSTACLE.instantiate()
	obs.on_plane_crash.connect(_on_plane_crash)
	obs.on_player_score.connect(_on_player_score)
	
	var viewport: Rect2 = get_viewport_rect() 
	obs.position.x = viewport.end.x + 150
	
	var half = viewport.size.y / 2
	obs.position.y = randf_range(half + 200, half - 200)
	
	# it should be on bottom so there is no flickery for player (with interpolation)
	add_child(obs)

func stop_obstacles() -> void:
	timer.stop()
	for node: Obstacle in get_children().filter(func(node): return node is Obstacle):
		node.set_speed(0)

func _on_player_score() -> void:
	on_player_score.emit()

func _on_plane_crash() -> void:
	on_obstacle_crash.emit()
	stop_obstacles()

func _on_timer_timeout() -> void:
	create_obstacle()
