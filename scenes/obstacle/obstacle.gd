extends Node2D

class_name Obstacle

signal on_plane_crash
signal on_player_score

@export var move_speed: float = 150

func set_speed(speed: float) -> void:
	move_speed = speed
	

func _process(delta: float) -> void:
	position.x -= move_speed * delta


func _on_top_body_entered(body: Node2D) -> void:
	if not body is Player: return
	on_plane_crash.emit()


func _on_bottom_body_entered(body: Node2D) -> void:
	if not body is Player: return
	on_plane_crash.emit()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_score_body_entered(body: Node2D) -> void:
	on_player_score.emit()
