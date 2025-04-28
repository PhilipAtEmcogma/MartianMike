extends Control


func _on_button_pressed() -> void:
	#another way to change scene.  triggered by button presson the ok button on win screen.
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
