extends Node2D

@export var next_level: PackedScene = null

@onready var start = $Start
@onready var exit = $Exit
@onready var death_zone = $Deathzone

var player = null

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
		if next_level != null:
			#load next level, after playing animation
			exit.animate()
			player.active = false
			await get_tree().create_timer(1.5).timeout #timeout for 1.5 sec before change scene, so animation can play
			#packed is packed scene is Godot way to store scene files.
			get_tree().change_scene_to_packed(next_level)
