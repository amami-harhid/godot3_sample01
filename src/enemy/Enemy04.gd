extends Node2D
onready var main:Main = self.get_tree().root.get_node('Main')
onready var body:RigidBody2D = $EnemyBody
onready var sprite:Sprite = $EnemyBody/Sprite
onready var collision:CollisionShape2D = $EnemyBody/CollisionShape2D

signal atack_count_up(_atack_counter)

func _ready():
	yield(self.get_tree(), "idle_frame")
#	body.sleeping = true
#	body.visible = false
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
	
var random = RandomNumberGenerator.new()
const COLORS = [Color.green, Color.rebeccapurple,Color.aquamarine,Color.cadetblue,Color.chartreuse]
func _clone_sprite():
	var _clone:RigidBody2D = body.duplicate()
	var _position = Vector2(rand_range(64*2,64*17),64*2)
	_clone.position = _position
	add_child(_clone)
	var r = random.randi_range(1, COLORS.size())
	var _color:Color = COLORS[r-1]
	_clone._set_clone(_color, random.randf_range(-10, 10))
	pass

		
