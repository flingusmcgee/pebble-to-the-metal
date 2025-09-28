extends Node2D

var isplacing = false
var money = 600
var health = 100
var credit = 0
var stopwatch = 0
var delay = 3

signal money_changed

func ready():
	$Timer.start()

func _process(delta):
	stopwatch += 1
	if stopwatch % 250 == 0:
		delay *= 0.96
	if stopwatch > 1 and stopwatch % 2400 == 0:
		flash()
		money /= 2
	if $Timer.is_stopped():
		$Timer.wait_time = delay
		spawn_enemy()
		$Timer.start()
	if !isplacing:
		if Input.is_action_just_pressed("arch"):
			if money >= 250:
				$Towers.add_child(load("res://node_2d.tscn").instantiate())
				isplacing = true
				credit = 250
		elif Input.is_action_just_pressed("bomb"):
			if money >= 400:
				$Towers.add_child(load("res://bomber.tscn").instantiate())
				isplacing = true
				credit = 400
		elif Input.is_action_just_pressed("snipe"):
			if money >= 700:
				$Towers.add_child(load("res://sniper.tscn").instantiate())
				isplacing = true
				credit = 700
	$MoneyLabel.text = "$" + str(money)
	$HealthLabel.text = str(health)
	$SpeedLabel.text = str(delay)
	if health <= 0:
		get_tree().change_scene_to_file("res://death.tscn")

func _input(event):
	if event is InputEventMouseButton:
		if isplacing:
			money -= credit
			isplacing = false
	
func spawn_enemy():
	print("new guy")
	var e = load("res://enemy.tscn").instantiate()
	$Path.add_child(e)
	e.killed.connect(_on_enemy_killed)
	e.passed.connect(_on_enemy_passed)

func _on_enemy_killed(revenue):
	money += revenue
	
func _on_enemy_passed(lives_lost):
	health -= lives_lost

func flash():
	if has_node("Topographic"): #js u ufse
		print("fhasing")
		var sprite = $Topographic
		sprite.modulate = Color(1, 0, 0) # turn red
		await get_tree().create_timer(0.2).timeout
		sprite.modulate = Color(1, 1, 1) # back to normal
