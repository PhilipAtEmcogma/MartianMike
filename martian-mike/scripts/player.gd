extends CharacterBody2D

@export var gravity = 400
@export var speed = 125
@export var jump_force = 200

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if is_on_floor() == false:
		velocity.y += gravity*delta
		if velocity.y >= 500:
			velocity.y = 500
	
	#go to Prpject > Project Setting > Input map to create new input mapping.
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = -jump_force
		
	#returns -1 if first argument (move_left) is met, returns 1 if second argument (move_right) is met, returns 0 if neither or both is met
	var direction = Input.get_axis("move_left", "move_right")
	#use the direction to flip the sprite horizontally according to direction. so it face the direction it's going 
	if direction !=0:
		animated_sprite.flip_h = (direction == -1) #NOTE: flip_h is flip horizontal an actual function in the sprite object
	velocity.x = direction * speed
	move_and_slide()
	
	update_animations(direction)
	
func update_animations(direction):
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		if velocity.y <0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")
