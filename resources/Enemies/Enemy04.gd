extends Node2D

onready var body:KinematicBody2D = $Body
onready var sprite:Sprite = $Body/Sprite

func _ready():
	sprite.visible = false
	_timer()
	
# このタイマーは Body をクローンし続ける！
func _timer():
	var _timer:Timer = Timer.new()
	_timer.one_shot = false
	_timer.wait_time = 0.2
	_timer.connect("timeout", self, "_animation")

func _animation():
	if not sprite.frame_coords.x < sprite.hframes:
		sprite.frame_coords.x = 0
	else:
		sprite.frame_coords.x += 1
		
