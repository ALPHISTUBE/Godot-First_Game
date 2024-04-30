extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var timer = $Timer
@onready var hurtS = $Hurt
@onready var deadS = $Dead
@onready var animation_player = $AnimationPlayer
@onready var game_manager = %GameManager
@onready var win = $"../Win"

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var dead = false
var hurt = false
var health = 2
var score = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _playerIsDead():
	deadS.playing = true
	dead = true
	win.visible = true
	$CollisionShape2D.queue_free()
	game_manager._onPlayerDead()
	animated_sprite.play("Dying")
	
func _playerIsHurt():
	hurtS.playing = true
	health -= 1
	hurt = true
	animated_sprite.play("Hurt")
	timer.start()

func _physics_process(delta):	
	game_manager.updateT(score, health)
	var dir = 0
	
	if hurt:
		velocity.y = JUMP_VELOCITY
		if animated_sprite.flip_h == true:
			dir = 1
		else:
			dir = -1
	
	if dead:
		animated_sprite.rotation += 50 * delta
	
	# Add the gravity.
	if not is_on_floor() and not hurt:
		velocity.y += gravity * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation_player.play("Jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.	
	if not dead:
		var direction = Input.get_axis("move_left", "move_right")
	
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true
		
		if is_on_floor() and not dead and not hurt:
			if direction == 0:
				animated_sprite.play("Idle")
			elif direction != 0:
				animated_sprite.play("Run")
		elif not is_on_floor() and not dead and not hurt:
			animated_sprite.play("Jump")
		
		if direction:
			if hurt:
				velocity.x = dir * SPEED
			else:
				velocity.x = direction * SPEED
		else:
			if hurt:
				velocity.x = dir * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_timer_timeout():
	hurtS.playing = false
	hurt = false
