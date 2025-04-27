extends ParallaxBackground

#by puting the : after the variable name, it tells Godot that from now on this variable can only be
# the type it's assign to it after the :
@export var bg_texture: CompressedTexture2D = preload("res://assets/textures/bg/Blue.png")

@export var scroll_speed = 15

@onready var sprite = $ParallaxLayer/Sprite2D

func _ready() -> void:
	sprite.texture = bg_texture

func _process(delta: float) -> void:
	#scrolling the background image, independt to framerate.
	sprite.region_rect.position += delta * Vector2(scroll_speed, scroll_speed)
	if sprite.region_rect.position >= Vector2(64, 64):
		sprite.region_rect.position = Vector2.ZERO
