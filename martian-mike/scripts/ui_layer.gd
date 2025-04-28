extends CanvasLayer

#giving the flag a bool, so it only accepts true or false as argument.
func show_win_screen(flag: bool):
	$WinScreen.visible = flag
