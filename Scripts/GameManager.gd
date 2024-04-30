extends Node

var score = 0
@onready var score_label = %Score
@onready var score2 = $"../Win/HBoxContainer/Sprite2D3/Score"
@onready var health = $"../Win/HBoxContainer/Sprite2D4/Health"
@onready var healthT = %Health
@onready var flag = $"../Flag"
@onready var win = $"../Win"
@onready var q = $"../Win/Control/q"
@onready var r = $"../Win/Control/r"
@onready var mobile_control = $"../Mobile Control"

func addPoint(value):
	score += value
	score_label.text = str(score)
	score2.text = str(score)

func updateT(_score, _health):
	health.text = str(_health)
	healthT.text = str(_health)

func _on_flag_body_entered(body):
	win.visible = true
	_onPlayerDead()

func _on_r_button_down():
	Engine.time_scale = 1
	get_tree().reload_current_scene()

func _on_q_button_down():
	get_tree().quit()
	
func _onPlayerDead():
	mobile_control.visible = false
