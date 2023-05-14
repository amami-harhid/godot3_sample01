extends RigidBody2D

onready var enemyNode:Node2D = get_parent()
onready var sprite:Sprite = $Sprite
onready var collision:CollisionShape2D = $CollisionShape2D

var _this_is_clone := false

func _ready():
	collision.disabled = true # コリジョン無効状態
	sleeping = true # 本体はSleeping
	visible = false # 本体は非表示

func _set_clone(_color:Color, _speed:float):
	_this_is_clone = true
	collision.disabled = false  # コリジョン有効状態
	sleeping = false
	visible = true
	mass = 10
	gravity_scale = 0.1
	#sprite.modulate = _color
	#sprite.modulate.a = _color.a
	#sprite.modulate.b = _color.b
	#sprite.modulate.r = _color.r
	sprite.modulate = _color
	_rotation_speed = _speed if not _speed == 0 else 1.0
	_timer_animation()

var _rotation_speed:float = 0
func _process(delta):
	sprite.rotation_degrees += _rotation_speed
	collision.rotation_degrees = sprite.rotation_degrees
	

var _timer:Timer
func _timer_animation():
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
	


func _on_EnemyBody_body_entered(body):
	if not _this_is_clone:
		# 本体のときは何もしない
		return
	if body.name == 'Body':
		_remove_enemy()
	elif body.name == 'PlayingFieldTilemap':
		_remove_enemy_after_wait(0.5)

func _remove_enemy_after_wait(_wait_time:float):
		# 敵を消す用のタイマー
		var _timer:Timer = Timer.new()
		_timer.one_shot = true
		_timer.wait_time = _wait_time
		_timer.connect("timeout",self,"_remove_enemy")
		add_child(_timer)
		_timer.start() 
		# 敵を消す用のタイマーは子ノード。呼び出し先で子ノードを全部消すので後始末はOK。

func _remove_enemy():
	# このタイマーは実行中なので念のために止めておく（消す前に止める）
	self._timer.stop()
	# 自分の子ノードを全部消す
	_remove_all_children_node()
	# 自分を消す
	get_tree().queue_delete(self)

func _remove_all_children_node():
	self.hide() # visible = false と同じ
	self.sleeping = true # 物理計算を止める
	var _children = self.get_children()
	# 子ノードを全部消す
	for _child in _children:
		self.remove_child(_child)
