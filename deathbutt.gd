extends Button

func _ready():
	# ummm idk
	self.pressed.connect(_button_press)

func _button_press():
	print("go")
	get_tree().change_scene_to_file("res://map.tscn")
