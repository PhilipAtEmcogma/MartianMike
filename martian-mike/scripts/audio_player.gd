extends Node

var hurt = preload("res://assets/audio/hurt.wav")
var jump = preload("res://assets/audio/jump.wav")

func play_sfx(sfx_name: String):
	#load sfx accordingingly
	var stream = null
	if sfx_name == "hurt":
		stream = hurt
	elif sfx_name == "jump":
		stream = jump
	else:
		print("Invalid sfx name")
		return
	
	var asp = AudioStreamPlayer.new() #create an audio stream player instance
	asp.stream = stream
	asp.name = "SFX"
	
	add_child(asp)
	asp.play()
	await asp.finished #wait till sfx to finish
	#delete audio player instance after it finish plaaying
	asp.queue_free()
