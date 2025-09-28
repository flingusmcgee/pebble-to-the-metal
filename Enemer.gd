extends PathFollow2D

var speed = 0.05
var percentage = 0;
var health = 100;

signal killed(revenue)
signal passed(lives_lost)

func _ready():
	pass

func _process(delta):
	if progress_ratio < .99:
		walk(delta)
	else:
		print("removing")
		leaked(10)
		queue_free()
	
func walk(delta):
	percentage += delta * speed
	progress_ratio = percentage

var CorrectSound = preload("res://assets/sounds/hitHurt.wav")

func damaged(dmg):
	health -= dmg
	flash() # make it flash when hit
	$HURTERDOUNDER.stream = CorrectSound
	$HURTERDOUNDER.play()
	if health < 1:
		killed.emit(70)
		queue_free()

func leaked(lives_lost):
	passed.emit(lives_lost)

func flash():
	if has_node("Sprite2D"): #js u ufse
		var sprite = $Sprite2D
		sprite.modulate = Color(1, 0, 0) # turn red
		await get_tree().create_timer(0.1).timeout
		sprite.modulate = Color(1, 1, 1) # back to normal
