extends Node2D
@onready var raycast_right = $"RaycastRight"
@onready var raycast_left = $"RaycastLeft"
@onready var animated_sprite = $AnimatedSprite2D2

const  speed = 60
var dir = 1

func _process(delta):
	
	if raycast_right.is_colliding():
		dir = -1
		animated_sprite.flip_h = true
	if raycast_left.is_colliding():
		dir = 1
		animated_sprite.flip_h = false
		
	position.x += dir * speed * delta
