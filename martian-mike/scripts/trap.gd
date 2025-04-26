extends Node2D

signal touched_player

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		#follow 2 line of codes both are method to emit signal
		touched_player.emit()
		#emit_signal("touched_player")
