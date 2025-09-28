extends Node2D

signal shoot

@export var attack_speed = 0
@export var damage = 0
@export var cost = 0

signal purchase(cost)

var enemy_list = []
var target_position
var isplacing = true
var stopwatch = 0

func _ready():
	pass
	
func _physics_process(delta):
	stopwatch += 1;
	if isplacing:
		placing()
	else:
		lookat()

func _input(event):
	if event is InputEventMouseButton:
		isplacing = false

func lookat():
	if enemy_list.size() > 0:
		target_position = enemy_list[0].global_position
		$Turret.look_at(target_position)
		kill(enemy_list[0])

func placing():
	$Turret.get_parent().position = get_global_mouse_position()

func _on_area_2d_body_entered(body):
	enemy_list.append(body.get_parent())
	enemy_list.sort_custom(_compare_percentage)
	print(enemy_list)

func _on_area_2d_body_exited(body):
	enemy_list.erase(body.get_parent())
	enemy_list.sort_custom(_compare_percentage)
	print(enemy_list)

func kill(enemy):
	if stopwatch % attack_speed == 0:
		enemy.damaged(damage)
		print("shot")

func _compare_percentage(a, b):
	# return -1 if a should come before b, 1 if after, 0 if equal
	if a.percentage > b.percentage:
		return -1   # bigger percentage = first
	elif a.percentage < b.percentage:
		return 1
	return 0
