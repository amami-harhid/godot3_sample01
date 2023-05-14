extends RigidBody2D

onready var enemyNode:Node2D = get_parent()
onready var sprite:Sprite = $Sprite
onready var collision:CollisionShape2D = $CollisionShape2D

var _this_is_clone := false

# Called when the node enters the scene tree for the first time.
func _ready():
	collision.disabled = true
	sleeping = true # 本体はSleeping
	visible = false # 本体は非表示

func _set_clone():
	_this_is_clone = true
	collision.disabled = false
	sleeping = false
	visible = true
	mass = 10
	gravity_scale = 0.2
	_timer()
	

var _timer:Timer
func _timer():
	_timer = Timer.new()
	_timer.one_shot = false
	_timer.wait_time = 0.2
	_timer.connect("timeout",self,"_animation")
	add_child(_timer)
	_timer.start()
	

func _animation():
	if not sprite.frame_coords.x+1 < sprite.hframes:
		sprite.frame_coords.x = 0
	else:
		sprite.frame_coords.x += 1
	sprite.rotation_degrees += 30*PI
	collision.rotation_degrees = sprite.rotation_degrees
	


func _on_EnemyBody_body_entered(body):
	if not _this_is_clone:
		# 本体のときは何もしない
		return
	if body.name == 'Body':
		_remove_enemy()
	elif body.name == 'PlayingFieldTilemap':
		var _timer:Timer = Timer.new()
		_timer.one_shot = true
		_timer.wait_time = 0.5
		_timer.connect("timeout",self,"_remove_enemy")
		add_child(_timer)
		_timer.start()

func _remove_enemy():
	self._timer.stop()
	self.remove_child(_timer)
	self.sleeping = true
	self.hide()
	get_tree().queue_delete(self)
