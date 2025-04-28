extends Control


func _on_start_button_pressed() -> void:
	#change scene to first level when start button is pressed
	get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_quit_button_pressed() -> void:
	#quit game, when quit button is pressed.
	get_tree().quit()
