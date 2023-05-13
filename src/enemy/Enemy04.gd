extends Node2D
onready var main:Main = self.get_tree().root.get_node('Main')
onready var body:RigidBody2D = $EnemyBody
onready var sprite:Sprite = $EnemyBody/Sprite
onready var collision:CollisionShape2D = $EnemyBody/CollisionShape2D
func _ready():
	body.sleeping = true
	body.visible = false
	sprite.scale = Vector2(0.5,0.5)
	collision.scale = sprite.scale
	_timer()
	
# このタイマーは Body をクローンし続ける！
func _timer():
	var _timer:Timer = Timer.new()
	_timer.one_shot = false
	_timer.wait_time = 0.5
	_timer.connect("timeout", self, "_clone_sprite")
	add_child(_timer)
	_timer.start()

func _clone_sprite():
	var _clone:RigidBody2D = body.duplicate()
	var _position = Vector2(rand_range(64*2,64*17),64*2)
	_clone.position = _position
	add_child(_clone)
	_clone.visible = true
	_clone.sleeping = false
	pass

var _atack_count := 0
func atack():
	_atack_count+=1
	print(_atack_count)
	if _atack_count > 50:
		main.load_next_stage()
	
		
