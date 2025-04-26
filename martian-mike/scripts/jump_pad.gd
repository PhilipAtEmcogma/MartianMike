extends Area2D

@export var jump_force = 300

@onready var animated_sprite = $AnimatedSprite2D

func _on_body_entered(body: Node2D) -> void:
	#check if the body that enters the collision belongs to a certain class, in this case Player class
	# only then it'll triiger the animation and actions
	if body is Player:
		animated_sprite.play("Jump")
		body.jump(jump_force)
