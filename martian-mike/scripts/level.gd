extends Node2D

@export var next_level: PackedScene = null
@export var is_final_level:bool = false

@onready var start = $Start
@onready var exit = $Exit
@onready var death_zone = $Deathzone

@onready var hud = $UILayer/HUD
@onready var ui_layer = $UILayer

var player = null

@export var level_time = 5

var timer_node = null
var time_left

var win = false

func _ready():
	player = get_tree().get_first_node_in_group("player")#returns a single node
	
	if player != null:
		player.global_position = start.get_spawn_pos()
		
	player.global_position = start.get_spawn_pos() #reset player global position to start position
	#a groupd is like a tag that you can give to objects and group them together.
	var traps = get_tree().get_nodes_in_group("traps") #returns an array
	for trap in traps:
		#2 ways to connect signals via code:
		#trap.connect("touched_player",  _on_trap_touched_player)
		trap.touched_player.connect(_on_trap_touched_player)
	
	exit.body_entered.connect(_on_exit_body_entered)
	death_zone.body_entered.connect(_on_deathzone_body_entered)
	
	time_left = level_time
	hud.set_time_label(time_left)
	
	timer_node = Timer.new() #creating a new timer
	timer_node.name = "Level Timer"
	timer_node.wait_time = 1
	timer_node.timeout.connect(_on_level_timer_timeout)
	add_child(timer_node) #add timer to the level scene
	timer_node.start() #start the timer
	
func _on_level_timer_timeout():
	#only continue to count down if plaher hasn't win yet.
	if win == false:
		time_left -= 1
		hud.set_time_label(time_left)
		#when ran out of time, reset the level and the time_left
		if time_left <0:
			reset_player()
			time_left = level_time
			hud.set_time_label(time_left)

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func _on_deathzone_body_entered(body: Node2D) -> void:
	reset_player()


func _on_trap_touched_player() -> void:
	reset_player()
	
func reset_player():
	player.velocity = Vector2.ZERO #reset player velocity
	player.global_position = start.get_spawn_pos() #reset player global position to start position
	
func _on_exit_body_entered(body):
	if body is Player:
		#only switch to next level, if next level is loaded successfully.
		if is_final_level || (next_level != null):
			#load next level, after playing animation
			exit.animate()
			player.active = false
			win = true
			await get_tree().create_timer(1.5).timeout #timeout for 1.5 sec before change scene, so animation can play
			if is_final_level:
				ui_layer.show_win_screen(true)
			else:
				#packed is packed scene is Godot way to store scene files.
				get_tree().change_scene_to_packed(next_level)
