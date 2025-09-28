extends Node2D

var global_money = 10000

func _ready():
	pass
	

func _on_enemy_killed(revenue):
	global_money += revenue
