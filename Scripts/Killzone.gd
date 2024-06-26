extends Area2D
@onready var timer = $Timer

func _on_body_entered(body):
	if body.health <= 0:
		body._playerIsDead()
		Engine.time_scale = 0.5
		timer.start()
	else:
		body._playerIsHurt()


func _on_timer_timeout():
	Engine.time_scale = 1
